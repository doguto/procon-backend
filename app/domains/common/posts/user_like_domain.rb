module Common::Posts
  class UserLikeDomain < ApplicationDomain
    def execute(user_id:, post_id:)
      like = PostLikeCheckerService.new.exists?(post_id: post_id, user_id: user_id)
      if like
        like.destroy
      else
        Like.create(user_id: user_id, post_id: post_id)
      end
      true
    end
  end
end
