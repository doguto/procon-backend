module Posts
  class TimelineDomain
    def execute
      # 仮に現在のUserをid=1としている
      User.find(1)

      posts = Post.order(created_at: :desc).limit(50)
      dtos = []
      posts.each do |post|
        dto = PostDto.new(post)
        dtos.push(dto)
      end

      dtos
    end
  end
end
