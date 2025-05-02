class Api::V1::FollowsController < ApplicationController
    def index
        follows = Api::V1::Follows::Index.call
        render json: follows
    end

    def create
        result = Api::V1::Follows::Create.call(params[:follower_id], params[:followed_id])
        if result.success?
          render json: result.follow, status: :created
        else
          render json: { errors: result.errors }, status: :unprocessable_entity
        end
    end

    def destroy
        result = Api::V1::Follows::Destroy.call(params[:follower_id], params[:followed_id])
        if result.success?
          head :no_content
        else
          render json: { error: result.error }, status: :not_found
        end
    end
end
