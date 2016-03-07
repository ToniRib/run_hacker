require "rails_helper"

RSpec.describe GoogleTimezoneService do
  describe ".update_routes_with_timezones" do
    it "updates the route's associated location with a timezone" do
      workout = create(:workout)
      user = workout.user
      location = workout.location
      location.update_attribute(:local_timezone, nil)

      VCR.use_cassette("update_timezones") do
        GoogleTimezoneService.update_routes_with_timezones(user.id)
      end

      timezone = Location.pluck(:local_timezone).first

      expect(timezone).to eq("America/Denver")
    end
  end
end
