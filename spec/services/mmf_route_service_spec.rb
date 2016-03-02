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
  end
end
