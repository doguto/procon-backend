module Domains
    module Api
        module V1
            module Users
                class Index
                    def self.call
                        ::User.all
                    end
                end
            end
        end
    end
end