module Posts
  class TimelineDomain
    def execute
      Post.order(created_at: :desc).limit(50)
    end
  end
end
