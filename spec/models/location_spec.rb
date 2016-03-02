require 'rails_helper'

RSpec.describe Location, type: :model do
  describe ".create_from_api_response" do
    it "creates a location if it does not exist already" do
      location = Location.create_from_api_response(api_data)

      expect(Location.count).to eq(1)
      expect(location.city).to eq("Denver")
      expect(location.state).to eq("CO")
    end

    it "finds the location if it exists already" do
      location1 = Location.create_from_api_response(api_data)
      expect(Location.count).to eq(1)

      location2 = Location.create_from_api_response(api_data)
      expect(Location.count).to eq(1)

      expect(location1.id).to eq(location2.id)
    end
  end

  def api_data
    { city: "Denver", state: "CO" }
  end
end
