class SessionsController < ApplicationController
  def create
    user = User.find_or_create_by_auth(auth_hash)
    session[:user_id] = user.id
    redirect_to dashboard_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
