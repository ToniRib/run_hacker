require "rails_helper"

RSpec.describe GoogleElevationService do
  describe ".update_routes_with_elevation" do
    it "updates routes with cooresponding elevation based on lat lng" do
      workout = create(:workout)
      route = workout.route
      route.update_elevation(nil)
      user = workout.user

      VCR.use_cassette("update_elevations") do
        GoogleElevationService.update_routes_with_elevation(user.id)
      end

      expect(Route.pluck(:elevation)).to eq([1655.54797363281])
    end
  end
end
