class GoogleGeocoderService
  attr_reader :routes, :connection, :response

  def initialize(id)
    @routes = User.find(id).routes

    request_zipcodes
  end

  def self.update_routes_with_zipcodes(id)
    new(id)
  end

  private

  def request_zipcodes
    set_up_connection

    routes.each do |route|
      @response = get_api_response(route.starting_latitude,
                                   route.starting_longitude)

      update_with_zipcode(route) unless response[:results].empty?
    end
  end

  def update_with_zipcode(route)
    route.location.update_attribute(:zipcode, zipcode)
  end

  def address_components
    response[:results][0][:address_components]
  end

  def zipcode_row
    address_components.select { |r| r[:types].include?("postal_code") }
  end

  def zipcode
    zipcode_row[0][:long_name]
  end

  def google_geocode_url
    "https://maps.googleapis.com/maps/api/geocode/json"
  end

  def get_api_response(lat, lng)
    response = connection.get do |request|
      request.params["key"] = ENV["GOOGLE_GEOCODE_KEY"]
      request.params["latlng"] = "#{lat},#{lng}"
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
