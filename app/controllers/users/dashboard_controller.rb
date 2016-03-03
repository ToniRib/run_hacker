class Users::DashboardController < Users::BaseController
  def show
    @user = current_user
  end
end
