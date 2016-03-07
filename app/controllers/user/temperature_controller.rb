class User::TemperatureController < User::BaseController
  def index
    @user = Presenters::TemperaturePresenter.new(current_user)
  end
end
