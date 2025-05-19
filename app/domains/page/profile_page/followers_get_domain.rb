module Page::ProfilePage
  class FollowersGetDomain < ApplicationDomain
    def initialize(user_id:)
      super
      @user_id = user_id
    end

    def execute
      User.joins(:follows).where(follows: { followed_id: @user_id })
    end
  end
end
