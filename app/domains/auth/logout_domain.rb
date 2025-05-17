class Auth::LogoutDomain
  def initialize(cookies)
    @cookies = cookies
  end

  def execute
    @cookies.delete(:jwt)
  end
end
