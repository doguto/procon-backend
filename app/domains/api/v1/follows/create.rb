module Api
    module V1
        module Follows
            class Create
                Result = Struct.new(:success?, :follow, :errors)

                def self.call(follower_id, followed_id)
                    follow = :Follow.new(follower_id: follower_id, followed_id: followed_id)
                    if follow.save
                        Result.new(true, follow, nil)
                    else
                        Result.new(false, nil, follow.errors.full_messages)
                    end
                end
            end
        end
    end
end
