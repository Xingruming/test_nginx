module Skiffai

  class << self
    def get_completion(messages, model, &block)
      if model != 'skiff'
        Effyic.get_completion(messages, "http://172.16.1.251:10089", &block)
      else
        Effyic.get_completion(messages, "http://172.16.1.251:11189", &block)
      end
    end
  end

  module Effyic
    class << self
      def client(baseurl)
        Faraday.new(
          url: baseurl,
          headers: {
            'Content-Type' => 'application/json'
          }
        )
      end

      def stream(baseurl, payload, &block)
        client(baseurl).post("/query") do |req|
          req.body = payload.to_json
          req.options.on_data = Proc.new do |chunk, overall_received_bytes, env|
            words = chunk.to_s.gsub(/data:/, "")
            words.split("\n\n").each do |line|
              unless line.to_s.include?("[DONE]")
                choice = JSON.parse(line)["choices"][0]
                content = choice["delta"]
                finish_reason = choice["finish_reason"]
                block.call finish_reason, content unless content.to_s.empty?
              end
            end
          end
        end
        block.call "stop", ""
      end

      def un_stream(baseurl, payload)
        response = client(baseurl).post("/query") do |req|
          req.body = payload.to_json
        end

        if response.status == 200
          JSON.parse(response.body)["answer"]
        else
          raise "网络繁忙，请稍后重试～"
        end
      end

      def get_completion(messages, baseurl, &block)
        last_message = messages.pop
        prompt = last_message["content"] || last_message[:content]
        if block.respond_to?(:call)
          stream(baseurl, { text: prompt, instruction: nil, history: messages, stream: true }, &block)
        else
          un_stream(baseurl, { text: prompt, instruction: nil, history: messages, stream: false })
        end
      end
    end
  end

  private_constant :Effyic


end
