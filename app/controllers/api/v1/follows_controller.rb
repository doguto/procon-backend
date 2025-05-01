class Api::V1::FollowsController < ApplicationController
    def index
        follows = Follow.all
        render json: follows
    end

    def create
        follow = Follow.new(follower_id: params[:follower_id], followed_id: params[:followed_id])
        if follow.save
            render json: follow, status: :created
        else
            render json: { errors: follow.errors.full_messages }, status: :unprocessable_entity
        end
    end

    def destroy
        follow = Follow.find_by(follower_id: params[:follower_id], followed_id: params[:followed_id])
        if follow
            follow.destroy
            head :no_content
        else
            render json: { error: "Not found" }, status: :not_found
        end
    end
end
