require "active_support/concern"

module TimeOfDayDatasets
  extend ActiveSupport::Concern

  included do
    scope :has_routes, -> { where("route_id IS NOT NULL") }
    scope :has_average_speed, -> { where("average_speed IS NOT NULL") }

    def self.distance_time_of_day_and_total_time
      data = has_elapsed_time
              .has_routes
              .select(:distance, :starting_datetime, :elapsed_time, :route_id)

      map_total_time(data)
    end

    def self.distance_time_of_day_and_average_speed
      data = has_average_speed
              .has_routes
              .select(:distance, :starting_datetime, :average_speed, :route_id)

      map_average_speed(data)
    end

    def self.distance_time_of_day_and_time_spent_resting
      data = has_elapsed_time
              .has_active_time
              .where("elapsed_time - active_time > 0")
              .has_routes
              .select(:distance, :starting_datetime, :elapsed_time, :active_time, :route_id)

      map_time_spent_resting(data)
    end

    private

    def self.map_total_time(data)
      data.map do |workout|
        [workout.distance_in_miles,
         [2016, 1, 1,
          workout.starting_datetime_in_local_time.hour,
          workout.starting_datetime_in_local_time.min],
         workout.elapsed_time_in_minutes]
      end
    end

    def self.map_average_speed(data)
      data.map do |workout|
        [workout.distance_in_miles,
         [2016, 1, 1,
          workout.starting_datetime_in_local_time.hour,
          workout.starting_datetime_in_local_time.min],
         workout.average_speed_in_mph]
      end
    end

    def self.map_time_spent_resting(data)
      data.map do |workout|
        [workout.distance_in_miles,
         [2016, 1, 1,
          workout.starting_datetime_in_local_time.hour,
          workout.starting_datetime_in_local_time.min],
         workout.time_spent_resting]
      end
    end
  end
end
