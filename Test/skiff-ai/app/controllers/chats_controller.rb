class ChatsController < ApplicationController
  include ActionController::Live
  before_action :set_chat, only: %i[ show update destroy ]

  def index
    @chats = current_user.chats.where(model: params[:model]).order(id: :desc)
  end

  def show
  end

  def create
    @chat = current_user.chats.build(chat_params)

    if @chat.save
      render :show, status: :ok, location: @chat
    else
      render json: { message: '创建会话失败' }, status: :bad_request
    end
  end

  def update
    if @chat.update(chat_params)
      render :show, status: :ok, location: @chat
    else
      render json: { message: '更新会话失败' }, status: :bad_request
    end
  end

  def destroy
    @chat.destroy!

    head :ok
  end

  private

    def set_chat
      @chat = current_user.chats.find(params[:id])
    end

    def chat_params
      params.require(:chat).permit(:name, :model)
    end
end
