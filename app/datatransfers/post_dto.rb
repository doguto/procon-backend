class PostDto
  def initialize(post)
    @post = post
  end

  def as_json
    {
      id: @post.id,
      content: @post.content,
      created_at: @post.created_at,
      updated_at: @post.updated_at,
      user_id: @post.user_id,
      reply_to_id: @post.reply_to_id,
      user: {
        id: @post.user.id,
        name: @post.user.name,
        image: @post.user.image
      },
      replies_count: @post.replies.count,
      likes_count: @post.likes.count,
      reposts_count: @post.reposts.count
    }
  end
end
