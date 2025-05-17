class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session # CSRFエラーを防ぐ（API対応）

  before_action :set_current_user

  private

  def set_current_user
    token = cookies.signed[:jwt]
    if token
      decoded = JsonWebToken.decode(token)
      @current_user = User.find_by(id: decoded[:user_id]) if decoded
    end
  rescue JWT::DecodeError
    @current_user = nil
  end

  attr_reader :current_user

  def authenticate_user!
    render json: { error: "Not Authorized" }, status: :unauthorized unless current_user
  end
end
