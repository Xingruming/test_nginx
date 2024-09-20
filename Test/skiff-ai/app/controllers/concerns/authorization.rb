module Authorization
  extend ActiveSupport::Concern

  included do
    before_action :authorized!
  end

  private

    def encode_token(payload)
      # 七天有效时间
      expiration_time = Time.now.to_i + 7.days.to_i
      JWT.encode(payload, ENV['SECRET_KEY_BASE'], "HS256", { exp: expiration_time })
    end

    def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
    end

    def get_token
      # header: { 'Authorization': 'Bearer <token>' }
      auth_header.split(' ')[1]
    end

    def decoded_token
      if auth_header
        begin
          JWT.decode(get_token, ENV['SECRET_KEY_BASE'], true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
    end

    def logged_in_user
      if decoded_token
        user_id = decoded_token[0]['user_id']
        @current_user = User.find_by(id: user_id)
      end
    end

    def logged_in?
      !!logged_in_user
    end

    def authorized
      head :ok unless logged_in?
    end

    def authorized!
      render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end

  private

    attr_reader :current_user
end
