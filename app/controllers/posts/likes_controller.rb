class Posts::LikesController < ApplicationController
  def create
    domain = UserLikeDomain.new
    successon = domain.execute(user_id: params[:user_id], post_id: params[:post_id])

    render json: { message: "Success" }, status: :ok if successon
  end
end
