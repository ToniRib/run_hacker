require "rails_helper"

RSpec.describe Point, type: :model do
  describe "#initialize" do
    it "can be initialized with valid parameters" do
      point = Point.new(time: 5.0,
                        lat: 38.78214621,
                        lng: -77.01499606,
                        elevation: 22.13)

      expect(point.time).to eq(5.0)
      expect(point.lat).to eq(38.78214621)
      expect(point.lng).to eq(-77.01499606)
      expect(point.elevation).to eq(22.13)
      expect(point.speed).to be_nil
      expect(point.distance).to be_nil
    end
  end

  describe "#add_distance" do
    it "adds the given distance to the point instance" do
      point = Point.new(time: 5.0,
                        lat: 38.78214621,
                        lng: -77.01499606,
                        elevation: 22.13)

      point.add_distance(10.2)

      expect(point.distance).to eq(10.2)
    end
  end

  describe "#add_speed" do
    it "adds the given speed to the point instance" do
      point = Point.new(time: 5.0,
                        lat: 38.78214621,
                        lng: -77.01499606,
                        elevation: 22.13)

      point.add_speed(5.2)

      expect(point.speed).to eq(5.2)
    end
  end

  describe "#coordinates" do
    it "returns the lat and lng as a hash" do
      point = Point.new(time: 5.0,
                        lat: 38.78214621,
                        lng: -77.01499606,
                        elevation: 22.13)

      coordinates = point.coordinates
      real_coordinates = { lat: 38.78214621, lng: -77.01499606 }

      expect(coordinates).to eq(real_coordinates)
    end
  end
end
