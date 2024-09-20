class TokensController < ApplicationController
  skip_before_action :authorized!

  def create
    @user = User.find_by(username: params[:username])

    raise "用户不存在" if @user.blank?

    if @user.authenticate(params[:password])
      render json: { token: encode_token(user_id: @user.id) }, status: :ok
    else
      render json: { message: "用户账号或密码不正确" }, status: :bad_request
    end
  end

end
