class WorkoutTimeseries
  attr_reader :points, :min_speed, :max_speed

  def initialize(data)
    @positions = data[:time_series][:position]
    @speeds    = data[:time_series][:speed]
    @distances = data[:time_series][:distance]
    @min_speed = data[:aggregates][:speed_min]
    @max_speed = data[:aggregates][:speed_max]
    @points    = add_points

    update_points_with_speed_and_distance
  end

  def min_speed_in_mph
    (min_speed * (3600 / 1609.344)).round(2)
  end

  def max_speed_in_mph
    (max_speed * (3600 / 1609.344)).round(2)
  end

  def max_elevation_in_feet
    convert_to_feet(points.max_by { |p| p.elevation }.elevation)
  end

  def min_elevation_in_feet
    convert_to_feet(points.min_by { |p| p.elevation }.elevation)
  end

  def route_coordinates
    points.map { |point| point.coordinates }
  end

  private

  def add_points
    @positions.map do |position|
      Point.new(time:      position[0],
                lat:       position[1][:lat],
                lng:       position[1][:lng],
                elevation: position[1][:elevation])
    end
  end

  def update_points_with_speed_and_distance
    @points.each do |point|
      distance = @distances.select { |time, distance| time == point.time }
      speed = @speeds.select { |time, speed| time == point.time }

      point.add_distance(distance[0][1])
      point.add_speed(speed[0][1])
    end
  end

  def convert_to_feet(height)
    (height * 3.28084).round(2)
  end
end
