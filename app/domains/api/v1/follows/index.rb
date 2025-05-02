
    module Api
        module V1
            module Follows
                class Index
                    def self.call
                        ::Follow.all
                    end
                end
            end
        end
    end
