class Auth::SetCurrentUserDomain
  def initialize(token)
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
