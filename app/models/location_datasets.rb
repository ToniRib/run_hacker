require "active_support/concern"

module TimeOfDayDatasets
  extend ActiveSupport::Concern

  included do
    def self.distance_location_and_total_time
      data = has_elapsed_time
               .has_routes
               .select(:distance, :starting_datetime, :elapsed_time, :route_id)

      map_time_of_day_total_time(data)
    end

    private

    def self.map_time_of_day_total_time(data)
      data.map do |workout|
        [workout.distance_in_miles,
         [2016, 1, 1,
          workout.starting_datetime_in_local_time.hour,
          workout.starting_datetime_in_local_time.min],
         workout.elapsed_time_in_minutes]
      end
    end
  end
end
