class User::LocationController < User::BaseController
  def index
    @workouts = UserWorkoutsCacher.new(current_user).cached_workouts_with_route_and_location
  end
end
