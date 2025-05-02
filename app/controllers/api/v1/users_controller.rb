class Api::V1::UsersController < ApplicationController
  def show
    user = Users::ShowUserWithProfileDomain.new(user_id: params[:id]).execute
    render json: user.as_json(include: :profile)
  end

  def create
    result = Users::CreateUserDomain.new(params: user_params).execute
    if result.succcess?
      render json: result.user, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def follow
    Follows::FollowUserDomain.new(follower_id: current_user.id, followed_id: params[:id]).execute
    head :no_content
  end

  def unfollow
    Follows::UnfollowUserDomain.new(follower_id: current_user.id, followed_id: params[:id]).execute
    head :no_content
  end

  def followers
    users = Follows::ListUserFollowDomain.new(user_id: params[:id]).followers
    render json: users
  end

  def following
    users = Follows::ListUserFollowDomain.new(user_id: params[:id]).following
    render json: users
  end

  private

  def user_params
    params.expect(user: [:name, :email, :password, :image])
  end
end
