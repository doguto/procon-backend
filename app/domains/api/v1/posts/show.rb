module Api
    module V1
        module Posts
            class Show
                def self.call(id)
                    ::Post.find(id)
                end
            end
        end
    end
end