class Api::V1::PostsController < ApplicationController
    def index 
        posts = Post.all
        render json: posts
    end

    def create
        post = Post.new(post_params)
        if post.save
            render json: post, status: :created
        else
            render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
    end

    private

    def post_params
        params.require(:post).permit(:text, :user_id)
    end
end
