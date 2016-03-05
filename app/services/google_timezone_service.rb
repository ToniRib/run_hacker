class GoogleTimezoneService
  attr_reader :routes, :connection, :response

  def initialize(id)
    @routes = User.find(id).routes

    request_timezones
  end

  def self.update_routes_with_timezones(id)
    new(id)
  end

  private

  def request_timezones
    set_up_connection

    routes.each do |route|
      next if route.location.local_timezone

      @response = get_api_response(route.starting_latitude,
                                   route.starting_longitude)

      update_with_timezone(route) unless response.empty?
    end
  end

  def update_with_timezone(route)
    route.update_local_timezone_of_location(timezone)
  end

  def timezone
    response[:timeZoneId]
  end

  def google_timezone_url
    "https://maps.googleapis.com/maps/api/timezone/json"
  end

  def get_api_response(lat, lng)
    response = connection.get do |request|
      request.params["key"] = ENV["GOOGLE_TIMEZONE_KEY"]
      request.params["location"] = "#{lat},#{lng}"
      request.params["timestamp"] = "1331161200"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def set_up_connection
    @connection = Faraday.new(url: google_timezone_url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
