module Page::AuthPage
  class AuthenticateUserDomain < ApplicationDomain
    def initialize(token)
      super
      @token = token
    end

    def execute
      decoded_token = JsonWebToken.decode(@token)
      user = User.find_by(id: decoded_token[:user_id])
      raise "Unauthorized" if user.nil?

      user
    end
  end
end
