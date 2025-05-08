module Posts
  class FetchUserPostsDomain
    def initialize(user:)
      @user = user
    end

    def execute
      Post.where(user: @user).order(created_at: :desc).map { |post| PostDto.new(post) }
    end
  end
end
