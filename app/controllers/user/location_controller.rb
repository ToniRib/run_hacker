class User::LocationController < User::BaseController
  def index
    # @workouts = UserWorkoutsCacher.new(current_user).cached_workouts_with_route_and_location
    @user = Presenters::LocationPresenter.new(current_user)
  end
end
