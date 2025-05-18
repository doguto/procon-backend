module Common::Posts
  class UserLikeDomain < ApplicationDomain
    def execute(user_id:, post_id:)
      like = UserLike.find_by(user_id: user_id, post_id: post_id)
      if like
        like.destroy
      else
        UserLike.create(user_id: user_id, post_id: post_id)
      end
      true
    end
  end
end
