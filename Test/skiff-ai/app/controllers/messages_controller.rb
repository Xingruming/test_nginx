class MessagesController < ApplicationController
  include ActionController::Live

  def index
    chat = current_user.chats.find(params[:chat_id])
    render json: chat.messages, status: :ok
  end

  def create
    @chat = current_user.chats.find(params[:chat_id])
    messages = @chat.history_messages
    messages << { role: Message::ROLE_USER, content: params[:user_content] }

    @message = @chat.messages.create!(
      user_content: params[:user_content],
      assistant_content: ""
    )

    content = ""
    response.headers['Content-Type'] = 'text/event-stream'
    response.headers['Last-Modified'] = Time.now.httpdate
    @sse = SSE.new(response.stream)

    Skiffai.get_completion(messages, @chat.model) do |finish_reason, assistant_content|
      content += assistant_content
      @sse.write({ content: content })
    end

  ensure
    @sse.write('[DONE]')
    @sse.close
    @message.update(assistant_content: content)
  end

end
