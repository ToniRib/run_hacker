require "rails_helper"

RSpec.describe WeathersourceTemperatureService do
  describe ".update_workouts_with_temperature" do
    it "updates workouts with temperature for that date, time, and location" do
      user = User.create(user_params)

      VCR.use_cassette("load_all_workouts") do
        MmfWorkoutAggregateService.load_workouts(user.id)
      end

      VCR.use_cassette("load_all_routes") do
        MmfRouteService.load_routes(user.id)
      end

      VCR.use_cassette("update_zipcodes") do
        GoogleGeocoderService.update_routes_with_zipcodes(user.id)
      end

      workout_ids = Workout.pluck(:id)[2..-1]
      Workout.destroy(workout_ids)

      expect(Workout.count).to eq(2)
      expect(Workout.pluck(:temperature)).to eq([nil, nil])

      VCR.use_cassette("update_temperatures") do
        WeathersourceTemperatureService.update_workouts_with_temperature(user.id)
      end

      expect(Workout.pluck(:temperature)).to eq([56.9, 71.7])
    end
  end
end
