require "rails_helper"

RSpec.describe GoogleElevationService do
  describe ".update_routes_with_elevation" do
    it "updates routes with cooresponding elevation based on lat lng" do
      user = create(:user_with_workouts_and_routes)
      user.routes.each { |r| r.update_elevation(nil) }

      expect(Route.count).to eq(2)
      expect(Route.pluck(:elevation)).to eq([nil, nil])

      VCR.use_cassette("update_elevations") do
        GoogleElevationService.update_routes_with_elevation(user.id)
      end

      expect(Route.pluck(:elevation)).to eq([1655.54797363281, 1655.54797363281])
    end
  end
end
