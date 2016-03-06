require "active_support/concern"

module TemperatureDatasets
  extend ActiveSupport::Concern

  included do
    scope :has_elapsed_time, -> { where("elapsed_time IS NOT NULL") }
    scope :has_active_time, -> { where("active_time IS NOT NULL") }
    scope :has_temperature, -> { where("temperature IS NOT NULL") }

    def self.distance_temperature_and_total_time
      data = has_temperature
               .has_elapsed_time
               .select(:distance, :temperature, :elapsed_time)

      map_temperature_total_time(data)
    end

    def self.distance_temperature_and_average_speed
      data = has_temperature
               .has_elapsed_time
               .select(:distance, :temperature, :average_speed)

      map_temperaure_average_speed(data)
    end

    def self.distance_temperature_and_time_spent_resting
      data = has_temperature
               .has_elapsed_time
               .has_active_time
               .where("elapsed_time - active_time > 0")
               .select(:distance, :temperature, :elapsed_time, :active_time)

      map_temperature_time_spent_resting(data)
    end

    private

    def self.map_temperature_total_time(data)
      data.map do |workout|
        [workout.distance_in_miles,
         workout.temperature,
         workout.elapsed_time_in_minutes]
      end
    end

    def self.map_temperaure_average_speed(data)
      data.map do |workout|
        [workout.distance_in_miles,
         workout.temperature,
         workout.average_speed_in_mph]
      end
    end

    def self.map_temperature_time_spent_resting(data)
      data.map do |workout|
        [workout.distance_in_miles,
         workout.temperature,
         workout.time_spent_resting_in_minutes]
      end
    end
  end
end
