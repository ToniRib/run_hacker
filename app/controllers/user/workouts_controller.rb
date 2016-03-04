class User::WorkoutsController < User::BaseController
  def index
    @user = current_user
  end

  def show
    @workout = Workout.find(params[:id])
    @workout_time_series = MmfWorkoutTimeseriesService.get_timeseries(@workout.map_my_fitness_id, current_user)
  end
end
