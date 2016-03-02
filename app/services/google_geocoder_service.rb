class GoogleGeocoderService
  attr_reader :routes, :connection, :response

  def initialize
    @routes = Route.no_location

    request_zipcodes
  end

  def self.update_routes_without_locations
    new
  end

  private

  def request_zipcodes
    set_up_connection

    routes.each do |route|
      @response = get_api_response(route.starting_latitude,
                                   route.starting_longitude)

      location = Location.find_by(zipcode: zipcode)

      route.update_attribute(:location_id, location.id)
    end
  end

  def address_components
    @response[:results][0][:address_components]
  end

  def zipcode
    zipcode_row = address_components.select do |r|
      r[:types].include?("postal_code")
    end

    zipcode_row[0][:long_name]
  end

  def google_geocode_url
    "https://maps.googleapis.com/maps/api/geocode/json"
  end

  def get_api_response(lat, lng)
    response = connection.get do |request|
      request.params["key"] = ENV["GOOGLE_GEOCODE_KEY"]
      request.params["latlng"] = "#{lat},#{lng}"
      request.params["sensor"] = "true"
      request.params["result_type"] = "postal_code"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def set_up_connection
    @connection = Faraday.new(:url => google_geocode_url,
                              :ssl => { verify: false }) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
