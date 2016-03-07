class Presenters::LocationPresenter < SimpleDelegator
  attr_reader :cached_workouts

  def initialize(model)
    super(model)
    @cached_workouts = UserWorkoutsCacher.new(model).cached_workouts_with_route_and_location
  end

  def distance_location_and_total_time
    data = cached_workouts
             .has_locations
             .has_elapsed_time
             .select("CONCAT(locations.city, ', ', locations.state) AS city_and_state",
                     :distance,
                     :elapsed_time,
                     :route_id)

    create_highcharts_data(data, :elapsed_time_in_minutes)
  end

  def distance_location_and_average_speed
    data = cached_workouts
             .has_locations
             .has_average_speed
             .select("CONCAT(locations.city, ', ', locations.state) AS city_and_state",
                     :distance,
                     :average_speed,
                     :route_id)

    create_highcharts_data(data, :average_speed_in_mph)
  end

  private

  def create_highcharts_data(data, type)
    group_by_city_and_state(data).map do |location, workouts|
      [location, get_converted_data(workouts, type)]
    end.to_h
  end

  def group_by_city_and_state(data)
    data.group_by { |w| w.city_and_state }
  end

  def get_converted_data(workouts, type)
    workouts.map { |workout| [workout.distance_in_miles, workout.send(type)] }
  end
end
