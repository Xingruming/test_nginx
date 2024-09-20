class DialoguesController < ApplicationController
  include ActionController::Live
  skip_before_action :authorized!

  def create
    if params[:stream]
      dialogues_by_stream
    else
      dialogues_by_normal
    end
  end

  private

    def dialogues_by_stream
      completion_content = ""
      response.headers['Content-Type'] = 'text/event-stream'
      response.headers['Last-Modified'] = Time.now.httpdate
      @sse = SSE.new(response.stream)

      unless auth?
        @sse.write({ choices: [{ delta: "", finish_reason: "stop" }], status: "failed", reason: "API_KEY 错误" })
        return
      end

      model = params[:model] || "skiff_constraint"
      # 检查模型是否合法
      unless Chat::MODELS.include?(model)
        @sse.write({ choices: [{ delta: "", finish_reason: "stop" }], status: "failed", reason: "model参数错误,model: #{model}" })
        return
      end

      index = 0
      messages = Array(params[:dialogue]).map do |m|
        if %w[user model assistant system].include?(m[:role])
          role = m[:role]
          role = :assistant if role == "model"
          if m[:content] == nil
            @sse.write({ choices: [{ delta: "", finish_reason: "stop" }], status: "failed", reason: "dialogue[#{index}].content应该为String,结果为null" })
            return
          end
          index += 1
          { role: role, content: m[:content] }
        end
      end

      max_tokens = params[:max_tokens]
      max_tokens = 4000 if max_tokens > 10000

      Skiffai.get_completion(messages, model) do |finish_reason, content|
        completion_content += content
        message = case finish_reason
                  when "length"
                    { choices: [{ delta: "", 'finish_reason': finish_reason }], status: "failed", reason: "该对话已超最大字数限制" }
                  when "stop"
                    { choices: [{ delta: content, 'finish_reason': finish_reason }], status: "success", reason: "success" }
                  else
                    { choices: [{ delta: content, 'finish_reason': nil }], status: "success", reason: "success" }
                  end

        @sse.write(message)
      end

    rescue Faraday::Error => e
      logger.info "[AI API ERROR]: Got a Faraday error: #{e}"
      @sse.write({ choices: [{ delta: "", 'finish_reason': "stop" }], status: "failed", reason: "请求错误，稍后再试" })
    rescue Exception => e
      logger.info "[AI API ERROR]: Got a Exception error: #{e}"
      @sse.write({ choices: [{ delta: "", 'finish_reason': "stop" }], status: "failed", reason: "请求错误，稍后再试" })
    ensure
      @sse.write('[DONE]')
      @sse.close
      Dialogue.create(user_content: params[:dialogue], assistant_content: completion_content)
    end

    def dialogues_by_normal
      content = ""
      result = { content: '', status: 'success', reason: 'success' }
      unless auth?
        result = { content: '', status: "failed", reason: "API_KEY 错误" }
        return
      end

      model = params[:model] || "skiff_constraint"
      # 检查模型是否合法
      unless Chat::MODELS.include?(model)
        result = { content: '', status: "failed", reason: "model参数错误, model: #{model}" }
        return
      end

      index = 0
      messages = Array(params[:dialogue]).map do |m|
        if %w[user model assistant system].include?(m[:role])
          role = m[:role]
          role = :assistant if role == "model"
          if m[:content] == nil
            result = { content: '', status: "failed", reason: "dialogue[#{index}].content应该为String,结果为null" }
            return
          end
          index += 1
          { role: role, content: m[:content] }
        end
      end

      max_tokens = params[:max_tokens]
      max_tokens = 4000 if max_tokens > 10000

      @result = { content: '', status: 'success', reason: '' }

      content = Skiffai.get_completion(messages, max_tokens)

      result[:content] = content
    rescue Faraday::Error => e
      logger.info "[AI API ERROR]: Got a Faraday error: #{e}"
      result[:reason] = "请求错误，稍后再试"
      result[:status] = "failed"
    rescue Exception => e
      logger.info "[AI API ERROR]: Got a Exception error: #{e}"
      result[:reason] = "请求错误，稍后再试"
      result[:status] = "failed"
    ensure
      Dialogue.create(user_content: params[:dialogue], assistant_content: content)
      render json: result, status: :ok
    end

    def auth?
      if request.headers['Authorization'].blank?
        false
      else
        token = request.headers['Authorization'].split(' ')[1]
        token == "skiff-4d5e91eadcb0931c088c9a80e79de2a466a2479d26cc"
      end
    end
end
