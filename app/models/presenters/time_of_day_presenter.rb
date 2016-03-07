class Presenters::TimeOfDayPresenter < SimpleDelegator
  attr_reader :cached_workouts

  def initialize(model)
    super(model)
    @cached_workouts = UserWorkoutsCacher.new(model).cached_workouts_with_route_and_location
  end

  def distance_time_of_day_and_total_time
    data = cached_workouts
             .has_elapsed_time
             .has_routes
             .select(:distance, :starting_datetime, :elapsed_time, :route_id)

    create_highcharts_data(data, :elapsed_time_in_minutes)
  end

  def distance_time_of_day_and_average_speed
    data = cached_workouts
             .has_average_speed
             .has_routes
             .select(:distance, :starting_datetime, :average_speed, :route_id)

    create_highcharts_data(data, :average_speed_in_mph)
  end

  def distance_time_of_day_and_time_spent_resting
    data = cached_workouts
             .has_elapsed_time
             .has_active_time
             .where("elapsed_time - active_time > 0")
             .has_routes
             .select(:distance, :starting_datetime, :elapsed_time, :active_time, :route_id)

    create_highcharts_data(data, :time_spent_resting_in_minutes)
  end

  private

  def create_highcharts_data(data, type)
    data.map do |workout|
      [workout.distance_in_miles,
       [2016, 1, 1,
        workout.starting_datetime_in_local_time.hour,
        workout.starting_datetime_in_local_time.min],
       workout.send(type)]
    end
  end
end
