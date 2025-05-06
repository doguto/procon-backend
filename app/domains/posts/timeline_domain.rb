module Posts
  class TimelineDomain
    def execute
      # 仮に現在のUserをid=1としている
      current_user = User.find(1)

      posts = Post.order(created_at: :desc).limit(50)
      dtos = []
      posts.each do |post|
        likes_num = Like.where(post_id: post.id).count
        reposts_num = Repost.where(post_id: post.id).count
        is_following = Follow.exists?(follower_id: current_user.id, followed_id: post.user.id)

        dto = TimelineDto.new(post: post, like_num: likes_num, repost_num: reposts_num, reply_num: 0, is_following: is_following)
        dtos.push(dto)
      end

      dtos
    end
  end
end
