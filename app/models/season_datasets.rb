require "active_support/concern"

module SeasonDatasets
  extend ActiveSupport::Concern

  included do
    def self.distance_season_and_total_time
      data = has_elapsed_time.select(:distance,
                                     :elapsed_time,
                                     :starting_datetime)

      season_statistics_elapsed_time(data)
    end

    def self.distance_season_and_average_speed
      data = has_average_speed.select(:distance,
                                      :average_speed,
                                      :starting_datetime)

      season_statistics_average_speed(data)
    end

    private

    def self.season_statistics_elapsed_time(data)
      group_by_season(data).map do |location, workout|
        [location, get_distance_and_time(workout)]
      end.to_h
    end

    def self.season_statistics_average_speed(data)
      group_by_season(data).map do |location, workout|
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

    def self.group_by_season(data)
      data.group_by { |w| w.season }
    end
  end
end
