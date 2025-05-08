class Api::V1::PostsController < ApplicationController
  def index
    posts = Posts::TimelineDomain.new.execute
    render json: posts.as_json(include: { user: { only: [:id, :name, :image] } })
  end

  def show
    post = Posts::ShowPostDomain.new(id: params[:id]).execute
    render json: post.as_json(include: { user: { only: [:id, :name, :image] } })
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not fount" }, status: :not_found
  end

  def create
    user = User.find(params[:post][:user_id])
    post = Posts::UserPostDomain.new(user: user).execute(content: params[:post][:content])
    render json: post, status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
  

  def user_posts
    posts = Posts::FetchUserPostsDomain.new(user: User.find(params[:user_id])).execute
    render json: posts.as_json(include: { user: { only: [:id, :name, :image] } })
  end

  private

  def post_params
    params.expect(post: [:content, :user_id])
  end
end
