module Posts
  class FetchUserPostsDomain
    def initialize(user:)
      @user = user
    end

    def execute
      Post.where(user: @user).order(created_at: :desc)
    end
  end
end
