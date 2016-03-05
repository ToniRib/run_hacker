require "rails_helper"

RSpec.describe GoogleTimezoneService do
  describe ".update_routes_with_timezones" do
    it "updates the route's associated location with a timezone" do
      user = User.create(user_params)

      VCR.use_cassette("load_all_workouts") do
        MmfWorkoutAggregateService.load_workouts(user.id)
      end

      VCR.use_cassette("load_all_routes") do
        MmfRouteService.load_routes(user.id)
      end

      expect(Location.count).to eq(16)
      expect(Location.pluck(:local_timezone)).to eq(Array.new(16, nil))

      VCR.use_cassette("update_timezones") do
        GoogleTimezoneService.update_routes_with_timezones(user.id)
      end

      timezones = Location.pluck(:local_timezone)

      expect(timezones.include?("America/Los_Angeles")).to be true
      expect(timezones.include?("America/Denver")).to be true
      expect(timezones.include?("America/Anchorage")).to be true
      expect(timezones.include?("America/New_York")).to be true
      expect(timezones.include?("America/Chicago")).to be true
    end
  end
end
