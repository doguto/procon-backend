class Api::V1::PostsController < ApplicationController
    def index 
        posts = Api::V1::Posts::Index.call
        render json: posts.as_json(include: { user: { only: [:id, :name, :email] }  })
    end

    def create
        result = Api::V1::Posts::Create.call(post_params)
        if result.success?
            render json: result.post, status: :created
        else
            render json: { errors: result.errors }, status: :unprocessable_entity
        end
    end

    private

    def post_params
        params.require(:post).permit(:text, :user_id)
    end
end
