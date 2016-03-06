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

      actual_zipcodes = Location.pluck(:zipcode)

      expect(actual_zipcodes.include?("90036")).to be true
      expect(actual_zipcodes.include?("90293")).to be true
      expect(actual_zipcodes.include?("90402")).to be true
      expect(actual_zipcodes.include?("92618")).to be true
      expect(actual_zipcodes.include?("80210")).to be true
      expect(actual_zipcodes.include?("99701")).to be true
      expect(actual_zipcodes.include?("80246")).to be true
      expect(actual_zipcodes.include?("80209")).to be true
      expect(actual_zipcodes.include?("80435")).to be true
      expect(actual_zipcodes.include?("80444")).to be true
      expect(actual_zipcodes.include?("55331")).to be true
      expect(actual_zipcodes.include?("80204")).to be true
      expect(actual_zipcodes.include?("20745")).to be true
      expect(actual_zipcodes.include?("80017")).to be true
    end
  end
end
