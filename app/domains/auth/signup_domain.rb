class Auth::SignupDomain
  def initialize(user_params)
    super()
    @user_params = user_params
  end

  def execute
    user = User.new(@user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      { token: token, user: user.slice(:id, :name, :email, :image) }
    else
      raise user.errors.full_messages.join(", ")
    end
  end
end
