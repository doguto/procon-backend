module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def initialize(id:)
      super()
      @user = User.find(id)
    end

    def execute
      post = Post.includes(:user, :replies, :likes, :reposts).find(@id)

      PostDetailDto.new(post, @user)
    end
  end
end
