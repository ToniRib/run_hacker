require "rails_helper"

RSpec.describe WeathersourceTemperatureService do
  describe ".update_workouts_with_temperature" do
    it "updates workouts with temperature for that date, time, and location" do
      user = create(:user_with_workouts_and_routes)
      user.workouts.each do |w|
        w.update_temperature(nil)
      end

      user.workouts.first.update_attribute(:starting_datetime, DateTime.new(2015,7,18,12,0,0))
      user.workouts.last.update_attribute(:starting_datetime, DateTime.new(2016,2,11,12,0,0))

      expect(Workout.count).to eq(2)
      expect(Workout.pluck(:temperature)).to eq([nil, nil])

      VCR.use_cassette("update_temperatures") do
        WeathersourceTemperatureService.update_workouts_with_temperature(user.id)
      end

      expect(Workout.pluck(:temperature)).to eq([57.7, 35.6])
    end
  end
end
