class AuthController < ApplicationController
  def signin
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token:, user: user.slice(:id, :name, :email, :image) }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  def signup
    user = User.new(signup_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token:, user: user.slice(:id, :name, :email, :image) }, status: :created
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

  private

  def signup_params
    params.expect(user: [:name, :email, :password, :password_confirmation, :image])
  end
end
