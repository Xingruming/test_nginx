class ApplicationController < ActionController::API
  include Authorization

  rescue_from Exception do |exception|
    render json: { message: "服务繁忙，请稍后重试" }, status: :bad_request
  end
end
