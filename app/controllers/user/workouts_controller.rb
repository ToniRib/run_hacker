class User::WorkoutsController < User::BaseController
  def index
    @workouts = current_user.workouts.includes(:route, :location)
  end

  def show
    @workout = Workout.find(params[:id])

    if @workout.has_time_series
      @time_series = Rails.cache.fetch("workout-#{@workout.map_my_fitness_id}") do
        service = MmfWorkoutTimeseriesService.new(@workout.map_my_fitness_id, current_user)
        service.get_timeseries
      end
    else
      flash["error"] = "Workout does not have a time series to display"
      redirect_to workouts_path
    end
  end
end
