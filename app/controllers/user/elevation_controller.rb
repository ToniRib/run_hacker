class User::ElevationController < User::BaseController
  def index
    @workouts = UserWorkoutsCacher.new(current_user).cached_workouts_with_route
  end
end
