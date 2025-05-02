class Api::V1::PostsController < ApplicationController
  def index
    posts = Posts::TimelineDomain.new.execute
    render json: posts.as_json(include: { user: { only: [:id, :name, :image] } })
  end

  def show
    post = Posts::ShowPostDomain.new(id: params[:id]).execute
    render json: post
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Post not fount" }, status: :not_found
  end

  def create
    Posts::UserPostDomain.new(user: current_user, params: post_params).execute
    render json: post, status: :created
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  def user_posts
    posts = Posts::FetchUserPostsDomain.new(user: User.find(params[:user_id])).execute
    render json: posts
  end

  private

  def post_params
    params.expect(post: [:content, :user_id])
  end
end
