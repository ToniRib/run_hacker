require "rails_helper"

RSpec.describe MmfWorkoutAggregateService do
  describe ".load_workouts" do
    it "loads all workouts for a given user if none exist" do
      user = User.create(user_params)

      VCR.use_cassette("load_all_workouts") do
        MmfWorkoutAggregateService.load_workouts(user.id)
      end

      expect(Workout.count).to eq(189)
    end

    it "loads only new workouts if user has some workouts" do
      user = User.create(user_params)

      VCR.use_cassette("load_all_workouts") do
        MmfWorkoutAggregateService.load_workouts(user.id)
      end

      Workout.last.destroy
      expect(Workout.count).to eq(188)
      expect(Workout.last.map_my_fitness_id).to eq(1322637635)

      # Note: this VCR was recorded a week later
      VCR.use_cassette("load_new_workouts") do
        MmfWorkoutAggregateService.load_workouts(user.id)
      end

      expect(Workout.count).to eq(192)
    end
  end
end
