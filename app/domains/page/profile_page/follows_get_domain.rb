module Page::ProfilePage
  class FollowsGetDomain < ApplicationDomain
    def initialize(user_id:)
      super
      @user_id = user_id
    end

    def execute
      User.joins(:inverse_follows).where(follows: { follower_id: @user_id })
    end
  end
end
