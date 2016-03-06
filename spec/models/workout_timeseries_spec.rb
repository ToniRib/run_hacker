require "rails_helper"

RSpec.describe WorkoutTimeseries, type: :model do
  describe "#initialize" do
    it "can be created with valid parameters" do
      timeseries = WorkoutTimeseries.new(api_data)

      point1, point2, point3 = timeseries.points
      min_speed = timeseries.min_speed
      max_speed = timeseries.max_speed

      expect(timeseries.points.count).to eq(3)

      expect(point1.distance).to eq(0.0)
      expect(point1.speed).to eq(0.0)
      expect(point1.elevation).to eq(22.13)
      expect(point1.lat).to eq(38.78214621)
      expect(point1.lng).to eq(-77.01499606)
      expect(point1.time).to eq(0.131)

      expect(point2.distance).to eq(14.8046369553)
      expect(point2.speed).to eq(0.5)
      expect(point2.elevation).to eq(20.76)
      expect(point2.lat).to eq(38.7822010006)
      expect(point2.lng).to eq(-77.0151513974)
      expect(point2.time).to eq(12.131)

      expect(point3.distance).to eq(29.529838562)
      expect(point3.speed).to eq(1.0)
      expect(point3.elevation).to eq(19.89)
      expect(point3.lat).to eq(38.7822198315)
      expect(point3.lng).to eq(-77.0153191478)
      expect(point3.time).to eq(14.131)
    end
  end

  describe "#min_speed_in_mph" do
    it "converts the minimum speed to mph from meters per second" do
      timeseries = WorkoutTimeseries.new(api_data)

      min_speed_in_mph = timeseries.min_speed_in_mph

      expect(min_speed_in_mph).to eq(10.22)
    end
  end

  describe "#max_speed_in_mph" do
    it "converts the maximum speed to mph from meters per second" do
      timeseries = WorkoutTimeseries.new(api_data)

      max_speed_in_mph = timeseries.max_speed_in_mph

      expect(max_speed_in_mph).to eq(18.67)
    end
  end

  describe "#min_elevation_in_feet" do
    it "converts the minimum elevation from meters to feet" do
      timeseries = WorkoutTimeseries.new(api_data)

      min_elevation_in_feet = timeseries.min_elevation_in_feet

      expect(min_elevation_in_feet).to eq(65.26)
    end
  end

  describe "#max_elevation_in_feet" do
    it "converts the maximum elevation from meters to feet" do
      timeseries = WorkoutTimeseries.new(api_data)

      max_elevation_in_feet = timeseries.max_elevation_in_feet

      expect(max_elevation_in_feet).to eq(72.6)
    end
  end

  describe "#route_coordinates" do
    it "returns the coordinates of all points as an array" do
      timeseries = WorkoutTimeseries.new(api_data)

      route_coordinates = timeseries.route_coordinates
      real_coordinates = [{:lat=>38.78214621, :lng=>-77.01499606},
                         {:lat=>38.7822010006, :lng=>-77.0151513974},
                         {:lat=>38.7822198315, :lng=>-77.0153191478}
      ]

      expect(route_coordinates).to eq(real_coordinates)
    end
  end

  describe "#has_elevations?" do
    it "returns true if any point has an elevation" do
      timeseries = WorkoutTimeseries.new(api_data)

      expect(timeseries.has_elevations?).to be true
    end

    it "returns false if there are no elevations" do
      timeseries = WorkoutTimeseries.new(api_data_without_elevations)

      expect(timeseries.has_elevations?).to be false
    end
  end

  def api_data
    {
      aggregates: {
        speed_min: 4.567,
        speed_max: 8.345
      },
      time_series: {
        position: [
          [0.131, {
              "lat": 38.78214621,
              "lng": -77.01499606,
              "elevation": 22.13
          }],
          [12.131, {
              "lat": 38.7822010006,
              "lng": -77.0151513974,
              "elevation": 20.76
          }],
          [14.131, {
              "lat": 38.7822198315,
              "lng": -77.0153191478,
              "elevation": 19.89
          }]
        ],
        speed: [
          [0.131, 0.0],
          [12.131, 0.5],
          [14.131, 1.0]
        ],
        distance: [
          [0.131, 0.0],
          [12.131, 14.8046369553],
          [14.131, 29.529838562]
        ]
      }
    }
  end

  def api_data_without_elevations
    {
      aggregates: {
        speed_min: 4.567,
        speed_max: 8.345
      },
      time_series: {
        position: [
          [0.131, {
              "lat": 38.78214621,
              "lng": -77.01499606
          }],
          [12.131, {
              "lat": 38.7822010006,
              "lng": -77.0151513974
          }],
          [14.131, {
              "lat": 38.7822198315,
              "lng": -77.0153191478
          }]
        ],
        speed: [
          [0.131, 0.0],
          [12.131, 0.5],
          [14.131, 1.0]
        ],
        distance: [
          [0.131, 0.0],
          [12.131, 14.8046369553],
          [14.131, 29.529838562]
        ]
      }
    }
  end
end
