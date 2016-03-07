class Presenters::ElevationPresenter < SimpleDelegator
  attr_reader :cached_workouts

  def initialize(model)
    super(model)
    @cached_workouts = UserWorkoutsCacher.new(model).cached_workouts_with_route
  end

  def distance_elevation_and_total_time
    data = cached_workouts
             .has_elevations
             .has_elapsed_time
             .select(:distance, :elevation, :elapsed_time, :route_id)

    create_highcharts_data(data, :elapsed_time_in_minutes)
  end

  def distance_elevation_and_average_speed
    data = cached_workouts
             .has_elevations
             .has_average_speed
             .select(:distance, :elevation, :average_speed, :route_id)

    create_highcharts_data(data, :average_speed_in_mph)
  end

  def distance_elevation_and_time_spent_resting
    data = cached_workouts
             .has_elevations
             .has_elapsed_time
             .has_active_time
             .where("elapsed_time - active_time > 0")
             .select(:distance, :elevation, :elapsed_time, :active_time, :route_id)

    create_highcharts_data(data, :time_spent_resting_in_minutes)
  end

  private

  def create_highcharts_data(data, type)
    data.map do |workout|
      [workout.distance_in_miles,
       workout.route.elevation_in_feet,
       workout.send(type)]
    end
  end
end
