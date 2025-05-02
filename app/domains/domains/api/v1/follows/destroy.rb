module Domains
    module Api
      module V1
        module Follows
          class Destroy
            Result = Struct.new(:success?, :error)
  
            def self.call(follower_id, followed_id)
              follow = ::Follow.find_by(follower_id: follower_id, followed_id: followed_id)
              if follow
                follow.destroy
                Result.new(true, nil)
              else
                Result.new(false, "Not found")
              end
            end
          end
        end
      end
    end
  end
  