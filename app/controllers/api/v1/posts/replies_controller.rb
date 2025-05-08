class Api::V1::Posts::RepliesController < ApplicationController
  def create
    user = User.find(params[:user_id])
    post = Posts::ReplyPostDomain.new(user: user).execute(
      content: params[:content],
      reply_to_id: params[:post_id]
    )
    render json: ReplyDto.new(post), status: :created
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User or Post not found" }, status: :not_found
  rescue StandardError => e
    render json: { error: e.message }, status: :unprocessable_entity
  end
end
