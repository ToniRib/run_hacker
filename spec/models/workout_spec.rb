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

  describe ".has_temperature" do
    it "returns only workouts where temperature is not nil" do
      workout1, workout2 = create_list(:workout, 2)
      workout2.update_temperature(nil)

      expect(Workout.has_temperature.count).to eq(1)
      expect(Workout.has_temperature.first.id).to eq(workout1.id)
    end
  end

  describe ".has_elapsed_time" do
    it "returns only workouts where elapsed time is not nil" do
      workout1, workout2 = create_list(:workout, 2)
      workout2.update_attribute(:elapsed_time, nil)

      expect(Workout.has_elapsed_time.count).to eq(1)
      expect(Workout.has_elapsed_time.first.id).to eq(workout1.id)
    end
  end

  describe ".has_active_time" do
    it "returns only workouts where active time is not nil" do
      workout1, workout2 = create_list(:workout, 2)
      workout2.update_attribute(:active_time, nil)

      expect(Workout.has_active_time.count).to eq(1)
      expect(Workout.has_active_time.first.id).to eq(workout1.id)
    end
  end

  describe ".no_routes" do
    it "returns only workouts where active time is nil" do
      workout1, workout2 = create_list(:workout, 2)
      workout2.update_attribute(:route_id, nil)

      expect(Workout.no_routes.count).to eq(1)
      expect(Workout.no_routes.first.id).to eq(workout2.id)
    end
  end

  describe ".by_descending_start_date" do
    it "returns workouts in order of descending start date" do
      workout1 = create(:workout, starting_datetime: DateTime.new(2015, 01, 01))
      workout2 = create(:workout, starting_datetime: DateTime.new(2016, 01, 01))

      workouts_in_order = Workout.by_descending_start_date

      expect(workouts_in_order.first).to eq(workout2)
      expect(workouts_in_order.last).to eq(workout1)
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

  describe "#average_speed_in_mph" do
    it "converts the speed to miles per hour" do
      workout = create(:workout)

      average_speed_in_mph = workout.average_speed_in_mph

      expect(average_speed_in_mph).to eq(5.97)
    end
  end

  describe "#distance_in_miles" do
    it "converts the distance from meters to miles" do
      workout = create(:workout)

      distance_in_miles = workout.distance_in_miles

      expect(distance_in_miles).to eq(5.05)
    end
  end

  describe "#starting_date_no_time" do
    it "returns the date the run was recorded as yyyy-mm-dd in local time" do
      workout = create(:workout,
                       starting_datetime: DateTime.new(2015, 05, 10, 12, 0, 0))

      date = workout.starting_date_no_time

      expect(date).to eq("2015-05-10")
    end
  end

  describe "#starting_time_only" do
    it "returns the time the run was recorded in the given timezone (Los Angeles)" do
      workout = create(:workout,
                       starting_datetime: DateTime.new(2015, 05, 10, 12, 0, 0))
      workout.location.update_local_timezone("America/Los_Angeles")

      date = workout.starting_time_only

      expect(date).to eq(" 5:00 am")
    end

    it "returns the time the run was recorded in the given timezone (Denver)" do
      workout = create(:workout,
                       starting_datetime: DateTime.new(2015, 05, 10, 12, 0, 0))
      workout.location.update_local_timezone("America/Denver")

      date = workout.starting_time_only

      expect(date).to eq(" 6:00 am")
    end
  end

  describe "#calories_burned_in_kcal" do
    it "returns the number of calories burned converted from joules to kcal" do
      workout = create(:workout)

      kcal = workout.calories_burned_in_kcal

      expect(kcal).to eq(650.0)
    end
  end

  describe "#elapsed_time_in_minutes" do
    it "returns the total elapsed time converted from seconds to minutes" do
      workout = create(:workout, elapsed_time: 600)

      time_in_minutes = workout.elapsed_time_in_minutes

      expect(time_in_minutes).to eq(10.0)
    end
  end

  describe ".distance_temperature_and_total_time" do
    it "returns nested arrays for records with temp that include total time" do
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300)
      workout2 = create(:workout, distance: 4000,
                                  temperature: 40,
                                  elapsed_time: 500)

      data = Workout.distance_temperature_and_total_time
      expected = [[4.97, 20.0, 5.0], [2.49, 40.0, 8.33]]

      expect(data).to eq(expected)
    end

    it "does not return records with no temperature" do
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300)
      workout2 = create(:workout, distance: 4000,
                                  temperature: nil,
                                  elapsed_time: 500)

      data = Workout.distance_temperature_and_total_time
      expected = [[4.97, 20.0, 5.0]]

      expect(data).to eq(expected)
    end
  end

  describe ".distance_temperature_and_average_speed" do
    it "returns nested arrays for records with temp that include avg speed" do
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  average_speed: 3)
      workout2 = create(:workout, distance: 4000,
                                  temperature: 40,
                                  average_speed: 5)

      data = Workout.distance_temperature_and_average_speed
      expected = [[4.97, 20.0, 6.71], [2.49, 40.0, 11.18]]

      expect(data).to eq(expected)
    end

    it "does not return records with no temperature" do
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  average_speed: 3)
      workout2 = create(:workout, distance: 4000,
                                  temperature: nil,
                                  average_speed: 5)

      data = Workout.distance_temperature_and_average_speed
      expected = [[4.97, 20.0, 6.71]]

      expect(data).to eq(expected)
    end
  end

  describe ".distance_temperature_and_time_spent_resting" do
    it "returns nested arrays for records with temp that include rest time" do
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300,
                                  active_time: 275)
      workout2 = create(:workout, distance: 4000,
                                  temperature: 40,
                                  elapsed_time: 500,
                                  active_time: 450)

      data = Workout.distance_temperature_and_time_spent_resting
      expected = [[4.97, 20.0, 25.0], [2.49, 40.0, 50.0]]

      expect(data).to eq(expected)
    end

    it "does not return records with no temperature" do
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300,
                                  active_time: 275)
      workout2 = create(:workout, distance: 4000,
                                  temperature: nil,
                                  elapsed_time: 500,
                                  active_time: 450)

      data = Workout.distance_temperature_and_time_spent_resting
      expected = [[4.97, 20.0, 25.0]]

      expect(data).to eq(expected)
    end

    it "does not return records where time spent resting is negative" do
      workout1 = create(:workout, distance: 8000,
                                  temperature: 20,
                                  elapsed_time: 300,
                                  active_time: 275)
      workout2 = create(:workout, distance: 4000,
                                  temperature: 40,
                                  elapsed_time: 400,
                                  active_time: 450)

      data = Workout.distance_temperature_and_time_spent_resting
      expected = [[4.97, 20.0, 25.0]]

      expect(data).to eq(expected)
    end
  end

  def api_data_with_distance
    {
      start_datetime: "2015-03-11 22:15:31",
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
      start_datetime: "2015-03-11 22:15:31",
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
