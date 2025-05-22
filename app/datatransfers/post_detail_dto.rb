class PostDetailDto
  def initialize(post, current_user: nil, liked_by_current_user: false)
    @post = post
    @current_user = current_user
    @liked_by_current_user = liked_by_current_user
  end

  def get
    {
      "id" => @post.id,
      "content" => @post.content,
      "created_at" => @post.created_at,
      "updated_at" => @post.updated_at,
      "user_id" => @post.user_id,
      "reply_to_id" => @post.reply_to_id,
      "user" => {
        "id" => @post.user.id,
        "name" => @post.user.name,
        "image" => @post.user.image,
        "is_following" => @liked_by_current_user
      }.camelize,
      "replies_count" => @post.replies.count,
      "likes_count" => @post.likes.count,
      "reposts_count" => @post.reposts.count,
      "replies" => @post.replies.order(created_at: :asc).map { |post| PostDetailDto.new(post, @current_user).get }
    }.camelize
  end
end
