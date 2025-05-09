class PostsController < ApplicationController
    
    def index
        # @posts = Post.order(created_at: :desc)
        # puts @posts.inspect  # デバッグ用
        render "posts/index"
    end

    # def new
    #   @post = Post.new
    # end
  
    # def create
    #   @post = Post.new(post_params)
    #   if @post.save
    #     redirect_to posts_path, notice: "投稿が作成されました"
    #   else
    #     render :new, status: :unprocessable_entity
    #   end
    # end
  
    # private
  
    # def post_params
    #   params.require(:post).permit(:text)
    # end

    
end