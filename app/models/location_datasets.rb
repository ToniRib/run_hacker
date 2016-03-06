require "active_support/concern"

module LocationDatasets
  extend ActiveSupport::Concern

  included do
    def self.distance_location_and_total_time
      data = has_locations
               .has_elapsed_time
               .select("CONCAT(locations.city, ', ', locations.state) AS city_and_state",
                       :distance,
                       :elapsed_time,
                       :route_id)

      location_statistics(data)
    end

    private

    def self.location_statistics(data)
      grouped = group_by_city_and_state(data)
      grouped.map { |location, w| [location, get_distance_and_time(w)] }.to_h
    end

    def self.get_distance_and_time(workouts)
      workouts.map do |workout|
        [workout.distance_in_miles, workout.elapsed_time_in_minutes]
      end
    end

    def self.group_by_city_and_state(data)
      data.group_by { |w| w.city_and_state }
    end
  end
end
