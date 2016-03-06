require "active_support/concern"

module DashboardAggregates
  extend ActiveSupport::Concern

  included do
    def self.total_distance_in_miles
      (sum(:distance) / 1609.344).round(2)
    end

    def self.average_distance_in_miles
      (total_distance_in_miles / count).round(2)
    end

    def self.total_time_in_hours
      (sum(:elapsed_time) / 3600).round(2)
    end

    def self.total_calories_in_kcal
      (sum(:metabolic_energy) / 4184).round(0)
    end
  end
end
