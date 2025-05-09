module Posts
  class ReplyPostDomain
    def initialize(user_id:)
      @user_id = user_id
    end

    def execute(content:, reply_to_id:)
      user = User.find(@user_id)
      post = Post.new(user: user, content: content, reply_to_id: reply_to_id)
      if post.save
        post
      else
        raise DomainError, post.errors.full_messages.join(", ")
      end
    end
  end
end
