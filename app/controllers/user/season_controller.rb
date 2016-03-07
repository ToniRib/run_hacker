class User::SeasonController < User::BaseController
  def index
    @user = Presenters::SeasonPresenter.new(current_user)
  end
end
