module Domains
    module Api
      module V1
        module Posts
          class Index
            def self.call
              ::Post.all
            end
          end
        end
      end
    end
  end
  