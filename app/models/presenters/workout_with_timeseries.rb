class Presenters::WorkoutWithTimeseries < SimpleDelegator
  attr_reader :timeseries

  def initialize(workout, timeseries)
    super(workout)
    @timeseries = timeseries
  end

  def display_temperature
    temperature ? "#{temperature} °F" : not_available
  end

  def display_elapsed_time
    elapsed_time ? "#{elapsed_time_in_minutes} minutes" : not_available
  end

  def display_calories_burned
    metabolic_energy ? "#{calories_burned_in_kcal} kcal" : not_available
  end

  def display_average_speed
    average_speed ? "#{average_speed_in_mph} mph" : not_available
  end

  def display_min_speed
    timeseries.min_speed ? "#{timeseries.min_speed_in_mph} mph" : not_available
  end

  def display_max_speed
    timeseries.max_speed ? "#{timeseries.max_speed_in_mph} mph" : not_available
  end

  def display_max_elevation
    timeseries.has_elevations? ? "#{timeseries.max_elevation_in_feet} ft" : not_available
  end

  def display_min_elevation
    timeseries.has_elevations? ? "#{timeseries.min_elevation_in_feet} ft" : not_available
  end

  private

  def not_available
    "Not Available"
  end
end
