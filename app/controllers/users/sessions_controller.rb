# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json
  private def respond_with(current_user, _opts = {})
    puts "Current user: #{current_user.inspect}"
    if current_user
      token = Warden::JWTAuth::UserEncoder.new.call(current_user, :user, nil).first
      render json: {
        status: {
          code: 200,
          message: 'Logged in successfully.',
          data: {
            user: UserSerializer.new(current_user).serializable_hash[:data][:attributes],
            token: token
          }
        }
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    current_user = nil

    if request.headers['Authorization'].present?
      begin
        token = request.headers['Authorization'].split(' ').last
        jwt_payload = JWT.decode(token, Rails.application.credentials.devise_jwt_secret_key!, true, algorithm: 'HS256').first
        Rails.logger.info("JWT Payload: #{jwt_payload.inspect}")
        current_user = User.find_by(jti: jwt_payload['jti'])
      rescue JWT::DecodeError => e
        Rails.logger.error("JWT Decode Error: #{e.message}")
      rescue JWT::IncorrectAlgorithm => e
        Rails.logger.error("JWT Incorrect Algorithm Error: #{e.message}")
      rescue StandardError => e
        Rails.logger.error("Unexpected error: #{e.message}")
      end
    else
      Rails.logger.warn("Authorization header not present")
    end
    if current_user
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    else
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
