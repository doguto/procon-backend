class ApplicationController < ActionController::API
  before_action :set_current_user

  private

  def set_current_user
    header = request.headers["Authorization"]
    token = header.split.last if header
    @current_user = Auth::SetCurrentUserDomain.new(token).execute
  end

  attr_reader :current_user

  def authenticate_user!
    render json: { error: "Not Authorized" }, status: :unauthorized unless current_user
  end
end
