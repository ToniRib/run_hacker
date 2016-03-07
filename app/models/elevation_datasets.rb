require "active_support/concern"

module ElevationDatasets
  extend ActiveSupport::Concern

  included do
    scope :has_elevations, -> { joins(:route).where("elevation IS NOT NULL") }

    def self.distance_elevation_and_total_time
      data = has_elevations
               .has_elapsed_time
               .select(:distance, :elevation, :elapsed_time, :route_id)

      map_elevation_total_time(data)
    end

    def self.distance_elevation_and_average_speed
      data = has_elevations
               .has_average_speed
               .select(:distance, :elevation, :average_speed, :route_id)

      map_elevation_average_speed(data)
    end

    def self.distance_elevation_and_time_spent_resting
      data = has_elevations
               .has_elapsed_time
               .has_active_time
               .where("elapsed_time - active_time > 0")
               .select(:distance, :elevation, :elapsed_time, :active_time, :route_id)

      map_elevation_time_spent_resting(data)
    end

    private

    def self.map_elevation_total_time(data)
      data.map do |workout|
        [workout.distance_in_miles,
         workout.route.elevation_in_feet,
         workout.elapsed_time_in_minutes]
      end
    end

    def self.map_elevation_average_speed(data)
      data.map do |workout|
        [workout.distance_in_miles,
         workout.route.elevation_in_feet,
         workout.average_speed_in_mph]
      end
    end

    def self.map_elevation_time_spent_resting(data)
      data.map do |workout|
        [workout.distance_in_miles,
         workout.route.elevation_in_feet,
         workout.time_spent_resting_in_minutes]
      end
    end
  end
end
