module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def initialize(id:)
      super()
      @id = id
    end

    def execute
      post = Post.includes(:user, :replies, :likes, :reposts).find(@id)
      PostDetailDto.new(post)
    end
  end
end
