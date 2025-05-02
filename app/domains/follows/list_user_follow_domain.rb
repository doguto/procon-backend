module Follows
  class ListUserFollowDomain
    def initialize(user_id:)
      @user_id = user_id
    end

    def followers
      User.joins(:follows).where(follows: { followed_id: @user_id })
    end

    def following
      User.joins(:inverse_follows).where(follows: { follower_id: @user_id })
    end
  end
end
