require "rails_helper"

RSpec.describe GoogleGeocoderService do
  describe ".update_routes_with_zipcodes" do
    it "updates the route's associated location with a zipcode" do
      user = User.create(user_params)

      VCR.use_cassette("load_all_workouts") do
        MmfWorkoutAggregateService.load_workouts(user.id)
      end

      VCR.use_cassette("load_all_routes") do
        MmfRouteService.load_routes(user.id)
      end

      expect(Location.count).to eq(16)
      expect(Location.pluck(:zipcode)).to eq(Array.new(16, nil))

      VCR.use_cassette("update_zipcodes") do
        GoogleGeocoderService.update_routes_with_zipcodes(user.id)
      end

      expect(Location.pluck(:zipcode)).to eq(zipcodes)
    end
  end

  def zipcodes
    [
      "90036", "90293", "90402", "92618", "80210", "99701", "80210",
      "80246", "80209", "80435", "80444", "55331", "80204", "20745",
      "80017", "26554"
    ]
  end
end
