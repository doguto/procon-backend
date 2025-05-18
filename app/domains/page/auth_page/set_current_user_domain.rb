module Page::AuthPage
  class SetCurrentUserDomain < ApplicationDomain
    def initialize(token)
      super
      @token = token
    end

    def execute
      return nil unless @token

      decoded = JsonWebToken.decode(@token)
      User.find_by(id: decoded[:user_id]) if decoded
    rescue JWT::DecodeError => e
      Rails.logger.warn("JWT::DecodeError occurred: #{e.message}")
      nil
    end
  end
end
