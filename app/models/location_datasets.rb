require "active_support/concern"

module LocationDatasets
  extend ActiveSupport::Concern

  included do
    scope :has_routes, -> { where("route_id IS NOT NULL") }
    scope :has_locations, -> { has_routes.joins(route: :location).where("location_id IS NOT NULL")}
    scope :has_average_speed, -> { where("average_speed IS NOT NULL") }

    def self.distance_location_and_total_time
      data = has_locations
               .has_elapsed_time
               .select("CONCAT(locations.city, ', ', locations.state) AS city_and_state",
                       :distance,
                       :elapsed_time,
                       :route_id)

      location_statistics_elapsed_time(data)
    end

    def self.distance_location_and_average_speed
      data = has_locations
               .has_average_speed
               .select("CONCAT(locations.city, ', ', locations.state) AS city_and_state",
                       :distance,
                       :average_speed,
                       :route_id)

      location_statistics_average_speed(data)
    end

    private

    def self.location_statistics_elapsed_time(data)
      group_by_city_and_state(data).map do |location, workout|
        [location, get_distance_and_time(workout)]
      end.to_h
    end

    def self.location_statistics_average_speed(data)
      group_by_city_and_state(data).map do |location, workout|
        [location, get_distance_and_average_speed(workout)]
      end.to_h
    end

    def self.get_distance_and_time(workouts)
      workouts.map do |workout|
        [workout.distance_in_miles, workout.elapsed_time_in_minutes]
      end
    end

    def self.get_distance_and_average_speed(workouts)
      workouts.map do |workout|
        [workout.distance_in_miles, workout.average_speed_in_mph]
      end
    end

    def self.group_by_city_and_state(data)
      data.group_by { |w| w.city_and_state }
    end
  end
end
