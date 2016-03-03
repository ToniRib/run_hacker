class User::BaseController < ApplicationController
  before_action :require_current_user

  def require_current_user
    unless current_user
      flash[:error] = "Must be logged in to view that page"
      redirect_to root_path
    end
  end
end
