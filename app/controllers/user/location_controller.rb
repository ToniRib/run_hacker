class User::LocationController < User::BaseController
  def index
    @user = Presenters::LocationPresenter.new(current_user)
  end
end
