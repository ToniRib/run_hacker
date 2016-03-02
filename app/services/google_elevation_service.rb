class GoogleElevationService
  attr_reader :connection, :routes, :response

  def initialize(id)
    @routes = User.find(id).routes

    set_up_connection
    request_elevations
  end

  def self.update_routes_with_elevation(id)
    new(id)
  end

  private

  def request_elevations
    routes.no_elevation.each do |route|
      @response = get_api_response(route.starting_latitude,
                                   route.starting_longitude)
      route.update_attribute(:elevation, elevation) unless response[:results].empty?
    end
  end

  def elevation
    response[:results][0][:elevation]
  end

  def google_elevation_url
    "https://maps.googleapis.com/maps/api/elevation/json"
  end

  def get_api_response(lat, lng)
    response = connection.get do |request|
      request.params["key"] = ENV['GOOGLE_ELEVATION_KEY']
      request.params["locations"] = "#{lat},#{lng}"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def set_up_connection
    @connection = Faraday.new(:url => google_elevation_url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
