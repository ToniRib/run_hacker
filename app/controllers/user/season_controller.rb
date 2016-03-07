class User::SeasonController < User::BaseController
  def index
    @workouts = UserWorkoutsCacher.new(current_user).cached_workouts
  end
end
