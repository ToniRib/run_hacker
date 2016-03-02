require "rails_helper"

RSpec.describe GoogleElevationService do
  describe ".update_routes_with_elevation" do
    it "updates routes with cooresponding elevation based on lat lng" do
      user = User.create(user_params)

      VCR.use_cassette("load_all_workouts") do
        MmfWorkoutAggregateService.load_workouts(user.id)
      end

      VCR.use_cassette("load_all_routes") do
        MmfRouteService.load_routes(user.id)
      end

      expect(Route.count).to eq(190)
      expect(Route.pluck(:elevation)).to eq(Array.new(190, nil))

      route_ids = Route.pluck(:id)[5..-1]
      Route.destroy(route_ids)

      expect(Route.count).to eq(5)

      VCR.use_cassette("update_elevations") do
        GoogleElevationService.update_routes_with_elevation(user.id)
      end

      expect(Route.pluck(:elevation).count).to eq(5)
      expect(Route.find(95).elevation).to eq(1602.82006835938)
    end
  end
end
