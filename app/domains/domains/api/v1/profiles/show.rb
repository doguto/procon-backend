module Domains
    module Api
      module V1
        module Profiles
          class Show
            def self.call(user_id)
              ::Profile.find_by(user_id: user_id)
            end
          end
        end
      end
    end
  end