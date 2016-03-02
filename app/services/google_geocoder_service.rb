class GoogleGeocoderService
  attr_reader :locations, :connection, :response

  def initialize
    @locations = Location.no_zipcode

    request_zipcodes
  end

  def self.update_locations_with_zipcodes
    new
  end

  private

  def request_zipcodes
    set_up_connection

    binding.pry

    locations.each do |location|
      @response = get_api_response(location.city, location.state)
      location.update_attribute(:zipcode, zipcode)
    end
  end

  def zipcode
    response[:results][0][:address_components][5][:long_name]
  end

  def google_geocode_url
    "http://maps.googleapis.com/maps/api/geocode/json"
  end

  def get_api_response(city, state)
    response = connection.get do |request|
      request.params["address"] = "#{city}+#{state}"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def set_up_connection
    @connection = Faraday.new(:url => google_geocode_url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
