class Presenters::SeasonPresenter < SimpleDelegator
  attr_reader :cached_workouts

  def initialize(model)
    super(model)
    @cached_workouts = UserWorkoutsCacher.new(model).cached_workouts
  end

  def distance_season_and_total_time
    data = cached_workouts
             .has_elapsed_time.select(:distance,
                                      :elapsed_time,
                                      :starting_datetime)

    create_highcharts_data(data, :elapsed_time_in_minutes)
  end

  def distance_season_and_average_speed
    data = cached_workouts
             .has_average_speed.select(:distance,
                                       :average_speed,
                                       :starting_datetime)

    create_highcharts_data(data, :average_speed_in_mph)
  end

  private

  def create_highcharts_data(data, type)
    group_by_season(data).map do |location, workouts|
      [location, get_converted_data(workouts, type)]
    end.to_h
  end

  def group_by_season(data)
    data.group_by { |w| w.season }
  end

  def get_converted_data(workouts, type)
    workouts.map { |workout| [workout.distance_in_miles, workout.send(type)] }
  end
end
