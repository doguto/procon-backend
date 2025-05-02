module Domains
    module Api
        module V1
            module Users
                class Show
                    def self.call(id)
                        ::User.find(id)
                    end
                end
            end
        end
    end
end