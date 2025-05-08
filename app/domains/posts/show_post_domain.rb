module Posts
  class ShowPostDomain
    def initialize(id:)
      @id = id
    end

    def execute
      post = Post.includes(:user, :replies, :likes, :reposts).find(@id)
      PostDetailDto.new(post)
    end
  end
end
