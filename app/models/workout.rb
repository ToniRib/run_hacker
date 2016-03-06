class Workout < ActiveRecord::Base
  include TemperatureDatasets
  include TimeOfDayDatasets
  include DashboardAggregates

  belongs_to :user
  belongs_to :route
  has_one    :location, through: :route

  scope :no_temperature, -> { where(temperature: nil) }
  scope :by_descending_start_date, -> { order(starting_datetime: :desc) }
  scope :no_routes, -> { where("route_id IS NULL") }

  def self.create_from_api_response(data)
    return if no_distance_or_no_route(data)

    workout = Workout.find_or_create_by(map_my_fitness_id: mmf_id(data))

    workout.starting_datetime       = data[:start_datetime]
    workout.has_time_series         = data[:has_time_series]
    workout.distance                = data[:aggregates][:distance_total]
    workout.average_speed           = data[:aggregates][:speed_avg]
    workout.active_time             = data[:aggregates][:active_time_total]
    workout.elapsed_time            = data[:aggregates][:elapsed_time_total]
    workout.metabolic_energy        = data[:aggregates][:metabolic_energy_total]
    workout.map_my_fitness_route_id = data[:_links][:route][0][:id]

    workout.save

    workout
  end

  def distance_in_miles
    (distance / 1609.344).round(2)
  end

  def average_speed_in_mph
    (average_speed * (3600 / 1609.344)).round(2)
  end

  def calories_burned_in_kcal
    (metabolic_energy / 4184).round(2)
  end

  def elapsed_time_in_minutes
    (elapsed_time / 60).round(2)
  end

  def starting_time_only
    starting_datetime.in_time_zone(local_timezone).strftime("%l:%M %P")
  end

  def starting_datetime_in_local_time
    starting_datetime.in_time_zone(local_timezone)
  end

  def update_temperature(temp)
    update_attribute(:temperature, temp)
  end

  def starting_date_no_time
    starting_datetime.in_time_zone(local_timezone).strftime("%Y-%m-%d")
  end

  def starting_date_in_iso_format
    starting_datetime.in_time_zone(local_timezone).strftime("%Y-%m-%-dT%H:%M")
  end

  def local_timezone
    location.local_timezone
  end

  def time_spent_resting
    elapsed_time - active_time
  end

  private

  def self.no_distance_or_no_route(data)
    data[:aggregates][:distance_total] == 0 || data[:_links][:route].nil?
  end

  def self.mmf_id(data)
    data[:_links][:self][0][:id]
  end
end
