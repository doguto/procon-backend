module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def initialize(id:, current_user:)
      super()
      @id = id
      @current_user = current_user
    end

    def execute
      post = Post.includes(:user, :replies, :likes, :reposts).find(@id)
      PostDetailDto.new(post, @current_user)
    end
  end
end
