module Page::AuthPage
  class SigninDomain < ApplicationDomain
    def initialize(email, password)
      super()
      @email = email
      @password = password
    end

    def execute
      user = User.find_by(email: @email)
      if user&.authenticate(@password)
        token = JsonWebToken.encode(user_id: user.id)
        [token, user]
      else
        raise "Invalid email or password"
      end
    end
  end
end
