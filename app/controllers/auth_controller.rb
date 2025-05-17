require "google-id-token"

class AuthController < ApplicationController
  def google
    result = Auth::GoogleAuthDomain.new(params[:credential]).execute
    token = write_jwt_token(User.find_by(email: result[:user][:email]))
    response.headers['Authorization'] = "Bearer #{token}"
    render json: result
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end

  def signin
    result = Auth::SigninDomain.new(params[:email], params[:password]).execute
    token = write_jwt_token(User.find_by(email: params[:email]))
    response.headers['Authorization'] = "Bearer #{token}"
    render json: result
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end

  def signup
    result = Auth::SignupDomain.new(signup_params).execute
    token = write_jwt_token(User.find_by(email: signup_params[:email]))
    response.headers['Authorization'] = "Bearer #{token}"
    render json: result, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def authenticate_user
    token = request.headers["Authorization"]&.split&.last
    @current_user = Auth::AuthenticateUserDomain.new(token).execute
  rescue StandardError => e
    render json: { error: e.message }, status: :unauthorized
  end

  def me
    authenticate_user
    render json: @current_user.slice(:id, :name, :email, :image)
  end

  def logout
    head :no_content
  end

  private

  def signup_params
    params.expect(user: [:name, :email, :password, :password_confirmation, :image])
  end

  def write_jwt_token(user)
    JsonWebToken.encode(user_id: user.id)
  end
end
