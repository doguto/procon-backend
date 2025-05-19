module Page::ProfilePage
  class FollowersGetDomain < ApplicationDomain
    def initialize(user_id:)
      super
      @user_id = user_id
    end

    def execute
      user = User.find(@user_id)
      user.follower_relationships.map(&:follower).map { |follower| User.find(follower.id) }
    end
  end
end
