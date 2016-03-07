class User::TimeOfDayController < User::BaseController
  def index
    @user = Presenters::TimeOfDayPresenter.new(current_user)
  end
end
