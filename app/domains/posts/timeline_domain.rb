module Posts
  class TimelineDomain
    def execute
      # 仮に現在のUserをid=1としている
      current_user = User.find(1)

      posts = Post.order(created_at: :desc).limit(50)
      dtos = []
      posts.each do |post|
        is_following = Follow.exists?(follower_id: current_user.id, followed_id: post.user.id)

        dto = TimelineDto.new(post: post, like_num: 1, repost_num: 2, reply_num: 0, is_following: is_following)
        dtos.push(dto)
      end

      dtos
    end
  end
end
