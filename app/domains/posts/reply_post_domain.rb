module Posts
  class ReplyPostDomain
    def initialize(user:)
      @user = user
    end

    def execute(content:, reply_to_id:)
      post = Post.new(user: @user, content: content, reply_to_id: reply_to_id)
      if post.save
        post
      else
        raise DomainError, post.errors.full_messages.join(", ")
      end
    end
  end
end
