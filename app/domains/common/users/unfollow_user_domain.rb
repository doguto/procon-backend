module Common::Users
  class UnfollowUserDomain < ApplicationDomain
    def initialize(follower_id:, followed_id:)
      super()
      @follower_id = follower_id
      @followed_id = followed_id
    end

    def execute
      follow = Follow.find_by(follower_id: @follower_id, followed_id: @followed_id)
      follow&.destroy
    end
  end
end
