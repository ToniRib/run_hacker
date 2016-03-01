class WeathersourceTemperatureService
  attr_reader :connection, :routes, :response

  def initialize(id)
    @routes = User.find(id).routes

    set_up_connection
    request_temperatures
  end

  def self.update_workouts_with_temperature(id)
    new(id)
  end

  private

  def request_temperatures
    workouts.no_temperature.each do |workout|
      @response = get_api_response(workout.created_at.to_json)
      # @response = get_api_response(route.starting_latitude,
      #                              route.starting_longitude)
      # route.update_attribute(:elevation, elevation) unless response[:results].empty?
    end
  end

  def weathersource_url
    "https://api.weathersource.com/v1/#{ENV['WEATHERSOURCE_KEY']}/history_by_postal_code.json"
  end

  def get_api_response(workout_start_time)
    response = connection.get do |request|
      request.params["period"] = "hour"
      request.params["postal_code_eq"] = zipcode # NEED THIS SOMEHOW
      request.params["timestamp_eq"] = workout_start_time
      request.params["country_eq"] = "US"
      request.params["fields"] = "temp"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def set_up_connection
    @connection = Faraday.new(:url => weathersource_url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
