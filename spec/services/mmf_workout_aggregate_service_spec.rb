require "rails_helper"

RSpec.describe MmfWorkoutAggregateService do
  describe ".load_workouts" do
    it "loads all workouts for a given user" do
      user = User.create(user_params)

      VCR.use_cassette("load_all_workouts") do
        MmfWorkoutAggregateService.load_workouts(user.id)
      end

      expect(Workout.count).to eq(189)
    end
  end
end
