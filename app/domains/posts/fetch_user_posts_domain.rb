module Posts
  class FetchUserPostsDomain
    def initialize(user_id:)
      @user_id = user_id
    end

    def execute
      @user = User.find(@user_id)
      Post.where(user: @user).order(created_at: :desc).map { |post| PostDto.new(post) }
    end
  end
end
