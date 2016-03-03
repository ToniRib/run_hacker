class User::WorkoutsController < User::BaseController
  def index
    @workouts = current_user.workouts
  end
end
