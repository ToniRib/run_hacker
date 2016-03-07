class User::ElevationController < User::BaseController
  def index
    @user = Presenters::ElevationPresenter.new(current_user)
  end
end
