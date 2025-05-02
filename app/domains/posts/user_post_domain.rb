module Posts
  class UserPostDomain
    def initialize(user:)
      @user = user
    end

    def execute(content:)
      post = Post.new(user: @user, content: content)
      if post.save
        post
      else
        raise DomainError, post.errors.full_messages.join(", ")
      end
    end
  end
end
