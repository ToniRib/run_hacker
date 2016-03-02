require 'rails_helper'

RSpec.describe Workout, type: :model do
  describe ".create_from_api_response" do
    it "creates a new workout if total distance is greater than 0" do
      workout = Workout.create_from_api_response(api_data_with_distance)

      expect(Workout.count).to eq(1)
      expect(workout.starting_datetime).to eq("2015-03-11 22:15:31")
      expect(workout.map_my_fitness_id).to eq(900975701)
      expect(workout.map_my_fitness_route_id).to eq(649215864)
      expect(workout.has_time_series).to be true
      expect(workout.distance).to eq(5429.39)
      expect(workout.average_speed).to eq(2.751)
      expect(workout.active_time).to eq(1974.0)
      expect(workout.elapsed_time).to eq(1973.0)
      expect(workout.metabolic_energy).to eq(1807488.0)
    end

    it "does not create a new workout if distance is 0" do
      workout = Workout.create_from_api_response(api_data_without_distance)

      expect(Workout.count).to eq(0)
    end
  end

  describe ".no_temperature" do
    it "returns only workouts where temperature is nil" do
      workout1, workout2 = create_list(:workout, 2)
      workout2.update_temperature(nil)

      expect(Workout.no_temperature.count).to eq(1)
      expect(Workout.no_temperature.first.id).to eq(workout2.id)
    end
  end

  describe "#update_temperature" do
    it "updates the temperature" do
      workout = create(:workout)

      workout.update_temperature(85)
      expect(workout.temperature).to eq(85)

      workout.update_temperature(72.5)
      expect(workout.temperature).to eq(72.5)
    end
  end

  describe "#starting_date_in_iso_format" do
    it "returns the starting time in the local timezone and formatted" do
      time = DateTime.new(2015, 3, 11, 8, 10, 20, '+0')
      workout = create(:workout, starting_datetime: time)

      expect(workout.starting_date_in_iso_format).to eq("2015-03-11T02:10")
    end
  end

  def api_data_with_distance
    {
      created_datetime: "2015-03-11 22:15:31",
      _links: {
        self: [{ id: 900975701 }],
        route: [{ id: 649215864 }]
      },
      has_time_series: true,
      aggregates: {
        distance_total: 5429.39,
        speed_avg: 2.751,
        active_time_total: 1974.0,
        elapsed_time_total: 1973.0,
        metabolic_energy_total: 1807488.0
      }
    }
  end

  def api_data_without_distance
    {
      created_datetime: "2015-03-11 22:15:31",
      _links: {
        self: [{ id: 900975701 }],
        route: [{ id: 649215864 }]
      },
      has_time_series: true,
      aggregates: {
        distance_total: 0,
        speed_avg: 2.751,
        active_time_total: 1974.0,
        elapsed_time_total: 1973.0,
        metabolic_energy_total: 1807488.0
      }
    }
  end
end
