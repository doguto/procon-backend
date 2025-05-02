
    module Api
      module V1
        module Posts
          class Create
            Result = Struct.new(:success?, :post, :errors)
  
            def self.call(params)
              post = ::Post.new(params)
              if post.save
                Result.new(true, post, nil)
              else
                Result.new(false, nil, post.errors.full_messages)
              end
            end
          end
        end
      end
    end
