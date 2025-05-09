class Api::V1::Posts::RepliesController < ApplicationController
  def create
    post = Posts::ReplyPostDomain.new(user_id: params[:user_id]).execute(
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
