module Follows
  class FollowUserDomain
    def initialize(follower_id:, followed_id:)
      @follower_id = follower_id
      @followed_id = followed_id
    end

    def execute
      Follow.find_or_create_by(follower_id: @follower_id, followed_id: @followed_id)
    end
  end
end
