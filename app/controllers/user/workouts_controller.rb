class User::WorkoutsController < User::BaseController
  before_action :check_if_workout_exists, only: [:show]
  before_action :check_owner_of_workout, only: [:show]

  def index
    @workouts = current_user.workouts.includes(:route, :location)
  end

  def show
    @workout = Rails.cache.fetch(workout_cache_name) do
      current_user.workouts.includes(:location).find(params[:id])
    end

    if @workout.has_time_series
      @time_series = load_time_series
    else
      flash["error"] = "Workout does not have a time series to display"
      redirect_to workouts_path
    end
  end

  private

  def workout_cache_name
    "workout-and-location-#{params[:id]}-#{Workout.find(params[:id]).updated_at}"
  end

  def load_time_series
    Rails.cache.fetch("workout-#{@workout.map_my_fitness_id}") do
      service = MmfWorkoutTimeseriesService.new(@workout.map_my_fitness_id,
                                                current_user)
      service.get_timeseries
    end
  end

  def check_owner_of_workout
    render file: "public/404" unless workout_belongs_to_current_user
  end

  def check_if_workout_exists
    render file: "public/404" unless workout_exists
  end

  def workout_exists
    Workout.exists?(params[:id])
  end

  def workout_belongs_to_current_user
    Workout.find(params[:id]).user.id == current_user.id
  end
end
