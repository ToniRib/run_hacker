require "rails_helper"

RSpec.describe GoogleGeocoderService do
  describe ".update_routes_with_zipcodes" do
    it "updates the route's associated location with a zipcode" do
      workout = create(:workout)
      location = workout.location
      location.update_zipcode(nil)
      user = workout.user

      VCR.use_cassette("update_zipcodes") do
        GoogleGeocoderService.update_routes_with_zipcodes(user.id)
      end

      zipcode = Location.pluck(:zipcode)

      expect(zipcode.include?("80231")).to be true
    end
  end
end
