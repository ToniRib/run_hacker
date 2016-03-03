require 'rails_helper'

RSpec.describe Route, type: :model do
  describe ".create_from_api_response" do
    it "creates a route with valid parameters" do
      location = create(:location)
      route = Route.create_from_api_response(api_data, location.id)

      expect(Route.count).to eq(1)
      expect(route.location_id).to eq(location.id)
      expect(route.starting_longitude).to eq(-104.90062083)
      expect(route.starting_latitude).to eq(39.67759636)
    end
  end

  describe "#update_elevation" do
    it "can be updated with an elevation" do
      location = create(:location)
      route = Route.create_from_api_response(api_data, location.id)

      route.update_elevation(1655.54797363281)
      expect(route.elevation).to eq(1655.54797363281)

      route.update_elevation(120.333393)
      expect(route.elevation).to eq(120.333393)
    end
  end

  describe ".no_elevation" do
    it "returns only routes without an elevation" do
      route1, route2 = create_list(:route, 2)
      route1.update_elevation(nil)

      expect(route1.elevation).to be_nil
      expect(route2.elevation).to_not be_nil

      route_with_no_elevation = Route.no_elevation
      expect(route_with_no_elevation.count).to eq(1)
      expect(route_with_no_elevation.first.id).to eq(route1.id)
    end
  end

  describe "#elevation_in_feet" do
    it "converts elevation from meters to feet" do
      route = create(:route, elevation: 10000)

      elevation_in_feet = route.elevation_in_feet

      expect(elevation_in_feet).to eq(32808.4)
    end
  end

  def api_data
    {
      starting_location: {
        coordinates: [-104.90062083, 39.67759636]
      }
    }
  end
end
