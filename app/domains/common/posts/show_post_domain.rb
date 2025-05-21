module Common::Posts
  class ShowPostDomain < ApplicationDomain
    def initialize()
      super()
    end

    def execute(id:, current_user:)
      post = Post.includes(:user, :replies, :likes, :reposts).find(id)
      liked = PostLikeCheckerService.new.exists?(post_id: post.id, user_id: current_user&.id)
      PostDetailDto.new(post, current_user, liked)
    end
  end
end
