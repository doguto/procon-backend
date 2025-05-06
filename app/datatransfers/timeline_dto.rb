class TimelineDto
  attr_reader :post, :like_num, :repost_num, :reply_num, :is_following

  def initialize(post:, like_num:, reply_num:, repost_num:, is_following:)
    @post = post
    @like_num = like_num
    @repost_num = repost_num
    @reply_num = reply_num
    @is_following = is_following
  end

  def as_json
    {
      post: @post.as_json(include: { user: { only: [:id, :name, :image] } }),
      like_num: @like_num,
      repost_num: @repost_num,
      reply_num: @reply_num,
      is_following: @is_following
    }
  end
end
