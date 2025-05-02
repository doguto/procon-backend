module Users
  class ShowUserWithProfileDomain
    def initialize(user_id:)
      @user_id = user_id
    end

    def execute
      User.includes(:profile).find(@user_id)
    end
  end
end
