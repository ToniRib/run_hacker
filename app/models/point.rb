class Point
  attr_reader :time, :lat, :lng, :elevation, :distance, :speed

  def initialize(time:, lat:, lng:, elevation:)
    @time      = time
    @lat       = lat
    @lng       = lng
    @elevation = elevation
  end

  def add_distance(distance)
    @distance = distance
  end

  def add_speed(speed)
    @speed = speed
  end
end
