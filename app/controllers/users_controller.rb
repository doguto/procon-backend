class UsersController < ApplicationController
  def show
    user = Page::ProfilePage::ShowUserWithProfileDomain.new(user_id: params[:id]).execute
    render json: user.as_json(include: :profile, except: [:password_digest, :password])
  end

  def create
    result = Common::Users::CreateUserDomain.new(params: user_params).execute
    if result.success?
      render json: result.user, status: :created
    else
      render json: { errors: result.errors }, status: :unprocessable_entity
    end
  end

  def follow
    Common::Users::FollowUserDomain.new(follower_id: current_user.id, followed_id: params[:id]).execute
    head :no_content
  end

  def unfollow
    Common::Users::UnfollowUserDomain.new(follower_id: current_user.id, followed_id: params[:id]).execute
    head :no_content
  end

  def followers
    users = Page::ProfilePage::ListUserFollowDomain.new(user_id: params[:id]).followers
    render json: users
  end

  def following
    users = Page::ProfilePage::ListUserFollowDomain.new(user_id: params[:id]).following
    render json: users
  end

  private

  def user_params
    params.expect(user: [:name, :email, :password, :image])
  end
end
