class ApplicationController < ActionController::API
  before_action :set_current_user

  private

  def set_current_user
    header = request.headers['Authorization']
    token = header.split.last if header
    if token
      decoded = JsonWebToken.decode(token)
      @current_user = User.find_by(id: decoded[:user_id]) if decoded
    end
  rescue JWT::DecodeError => e
    Rails.logger.warn("JWT::DecodeError occurred: #{e.message}")
    @current_user = nil
  end

  attr_reader :current_user

  def authenticate_user!
    render json: { error: "Not Authorized" }, status: :unauthorized unless current_user
  end
end
