class ApplicationController < ActionController::API
  before_action :set_current_user

  private

  def set_current_user
    header = request.headers["Authorization"]
    token = header.split.last if header
    @current_user = Page::AuthPage::SetCurrentUserDomain.new(token).execute
  end

  attr_reader :current_user

  def authenticate_user!
    render json: { error: "Not Authorized" }, status: :unauthorized unless current_user
  end

  def camelize_hash(hash)
    hash.transform_keys { |key| key.to_s.camelize(:lower) }
  end

  def camelize_json(json)
    json.transform_keys { |key| key.to_s.camelize(:lower) }
  end
end
