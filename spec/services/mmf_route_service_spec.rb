require "rails_helper"

RSpec.describe MmfRouteService do
  describe ".load_routes" do
    it "loads all the routes for the user" do
      user = User.create(user_params)

      VCR.use_cassette("load_all_routes") do
        MmfRouteService.load_routes(user.id)
      end

      expect(Route.count).to eq(190)
    end

    it "loads individual routes for new workouts" do
      user = User.create(user_params)

      VCR.use_cassette("load_all_workouts") do
        MmfWorkoutAggregateService.load_workouts(user.id)
      end

      VCR.use_cassette("load_all_routes") do
        MmfRouteService.load_routes(user.id)
      end

      Workout.last.update_attribute(:route_id, nil)

      VCR.use_cassette("load_new_routes_only") do
        MmfRouteService.load_routes(user.id)
      end

      expect(Workout.last.route_id).to_not be_nil
    end
  end
end
