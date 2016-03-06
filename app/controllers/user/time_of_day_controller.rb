class User::TimeOfDayController < User::BaseController
  def index
    @workouts = current_user.workouts.includes(:route, :location)
  end
end
