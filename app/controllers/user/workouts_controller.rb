class User::WorkoutsController < User::BaseController
  def index
    @user = current_user
  end
end
