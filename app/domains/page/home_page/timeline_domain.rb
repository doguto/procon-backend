module Page::HomePage
  class TimelineDomain < ApplicationDomain
    def execute(id:)
      posts = Post.order(created_at: :desc).limit(50)
      user = User.find(id)
      dtos = []
      posts.each do |post|
        dto = PostDto.new(post, user)
        dtos.push(dto)
      end

      dtos
    end
  end
end
