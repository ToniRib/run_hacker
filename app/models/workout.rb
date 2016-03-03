class Workout < ActiveRecord::Base
  belongs_to :user
  belongs_to :route
  has_one    :location, through: :route

  scope :no_temperature, -> { where(temperature: nil) }
  scope :has_temperature, -> { where("temperature IS NOT NULL") }
  scope :by_ascending_start_date, -> { order(starting_datetime: :asc) }

  def self.create_from_api_response(data)
    return if data[:aggregates][:distance_total] == 0

    Workout.create(starting_datetime: data[:created_datetime],
                   map_my_fitness_id: data[:_links][:self][0][:id],
                   has_time_series: data[:has_time_series],
                   distance: data[:aggregates][:distance_total],
                   average_speed: data[:aggregates][:speed_avg],
                   active_time: data[:aggregates][:active_time_total],
                   elapsed_time: data[:aggregates][:elapsed_time_total],
                   metabolic_energy: data[:aggregates][:metabolic_energy_total],
                   map_my_fitness_route_id: data[:_links][:route][0][:id]
    )
  end

  def update_temperature(temp)
    update_attribute(:temperature, temp)
  end

  def starting_date_in_iso_format
    starting_datetime.localtime.strftime("%Y-%m-%-dT%H:%M")
  end

  def starting_date_no_time
    starting_datetime.localtime.strftime("%Y-%m-%d")
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
    min = (elapsed_time / 60).round(2)
  end

  def self.distance_temperature_and_total_time
    has_temperature.pluck(:distance, :temperature, :elapsed_time)
  end

  def self.distance_temperature_and_average_speed
    has_temperature.pluck(:distance, :temperature, :average_speed)
  end

  def self.distance_temperature_and_time_spent_resting
    has_temperature
      .where("elapsed_time - active_time > 0")
      .pluck("distance",
             "temperature",
             "elapsed_time - active_time AS time_spent_resting")
  end
end
