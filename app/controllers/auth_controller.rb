require "google-id-token"

class AuthController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:google]

  def google
    credential = params[:credential]
    validator = GoogleIDToken::Validator.new
    payload = validator.check(credential, ENV.fetch("GOOGLE_CLIENT_ID", nil))
    user = User.find_or_create_by(email: payload["email"], provider: "google", uid: payload["sub"]) do |u|
      u.name = payload["name"]
      u.image = payload["picture"]
    end

    token = JsonWebToken.encode(user_id: user.id)
    render json: { token: token, user: user.slice(:id, :name, :email, :image) }
  rescue GoogleIDToken::ValidationError
    render json: { error: "Invalid Google token" }, status: :unauthorized
  end

  def signin
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = write_jwt_cookie(user)
      render json: { token: token, user: user.slice(:id, :name, :email, :image) }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def signup
    user = User.new(signup_params)
    if user.save
      token = write_jwt_cookie(user)
      render json: { token: token, user: user.slice(:id, :name, :email, :image) }, status: :created
    else
      render json: { error: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def authenticate_user
    token = request.headers["Authorization"]&.split&.last
    decoded_token = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded_token[:user_id])
    render json: { error: "Unauthorized" }, status: :unauthorized if @current_user.nil?
  end

  def me
    authenticate_user
    render json: @current_user.slice(:id, :name, :email, :image)
  end

  def logout
    cookies.delete(:jwt)
    head :no_content
  end

  private

  def signup_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def write_jwt_cookie(user)
    token = JsonWebToken.encode(user_id: user.id)
    cookies.signed[:jwt] = {
      value: token,
      httponly: true,
      expires: 1.hour.from_now,
      secure: Rails.env.production?,
      same_site: :lax
    }
    token
  end
end
