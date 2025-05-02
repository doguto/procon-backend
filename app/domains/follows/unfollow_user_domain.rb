module Follows
    class UnfollowUserDomain
        def initialize(follower_id:, followed_id:)
            @follower_id = follower_id
            @followed_id = followed_id
        end

        def execute
            follow = Follow.find_by(follower_id: @follower_id, followed_id: @followed_id)
            follow&.destroy
        end
    end
end