class User::DashboardController < User::BaseController
  def show
    @user = Presenters::DashboardPresenter.new(current_user)
  end
end
