module Posts
  class UserPostDomain
    def initialize(user_id:)
      @user_id = user_id
    end

    def execute(content:)
      user = User.find(@user_id)
      post = Post.new(user: user, content: content)
      if post.save
        post
      else
        raise DomainError, post.errors.full_messages.join(", ")
      end
    end
  end
end
