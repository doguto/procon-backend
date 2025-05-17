class Posts::LikesController < ApplicationController
  def create
    domain = UserLikeDomain.new
    domain.execute(user_id: params[:user_id], post_id: params[:post_id])
  end
end
