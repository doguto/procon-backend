class UserRepostDomain < ApplicationDomain
  def execute(user_id:, post_id:)
    repost = UserRepost.find_by(user_id: user_id, post_id: post_id)
    if repost
      repost.destroy
    else
      UserRepost.create(user_id: user_id, post_id: post_id)
    end

    true
  end
end
