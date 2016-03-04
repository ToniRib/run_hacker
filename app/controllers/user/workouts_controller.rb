class User::WorkoutsController < User::BaseController
  def index
    @user = current_user
  end

  def show
    @workout = Workout.find(params[:id])

    if @workout.has_time_series
      service = MmfWorkoutTimeseriesService.new(@workout.map_my_fitness_id, current_user)
      @time_series = service.get_timeseries
    end
  end
end
