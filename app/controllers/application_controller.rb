class ApplicationController < ActionController::API
  def current_user
    header = request.headers["Authorization"]
    token = header.split.last if header
    decoded = JsonWebToken.decode(token)
    @current_user ||= User.find_by(id: decoded[:user_id]) if decoded
  end

  def authenticate_user!
    render json: { error: "Not Authorized" }, status: :unauthorized unless current_user
  end
end
