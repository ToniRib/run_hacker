require "active_support/concern"

module TemperatureDatasets
  extend ActiveSupport::Concern

  included do
    def self.distance_temperature_and_total_time
      has_temperature
        .has_elapsed_time
        .pluck(:distance, :temperature, :elapsed_time)
    end

    def self.distance_temperature_and_average_speed
      has_temperature
        .has_elapsed_time
        .pluck(:distance, :temperature, :average_speed)
    end

    def self.distance_temperature_and_time_spent_resting
      has_temperature
        .has_elapsed_time
        .has_active_time
        .where("elapsed_time - active_time > 0")
        .pluck("distance",
               "temperature",
               "elapsed_time - active_time AS time_spent_resting")
    end
  end
end
