class User::WorkoutsController < User::BaseController
  before_action :check_if_workout_exists, only: [:show]
  before_action :check_owner_of_workout, only: [:show]

  def index
    workouts = UserWorkoutsCacher.new(current_user)
                                 .cached_workouts_with_route_and_location
    @workouts = workouts
                  .by_descending_start_date
                  .map { |w| Presenters::WorkoutPresenter.new(w) }
  end

  def show
    workout = UserWorkoutsCacher.new(current_user)
                                .cached_specific_workout(params[:id])

    if workout.has_time_series
      time_series = load_time_series(workout)
      redirect_to_workouts_and_render_error_flash unless confirmed(time_series)

      @workout = Presenters::WorkoutWithTimeseries.new(workout, time_series)
    else
      redirect_to_workouts_and_render_error_flash
    end
  end

  private

  def load_time_series(workout)
    service = MmfWorkoutTimeseriesService.new(workout.map_my_fitness_id,
                                              current_user)
    service.get_timeseries
  end

  def confirmed(time_series)
    time_series != "Timeseries Not Available"
  end

  def redirect_to_workouts_and_render_error_flash
    flash["error"] = "Workout does not have a time series to display"
    redirect_to workouts_path
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
