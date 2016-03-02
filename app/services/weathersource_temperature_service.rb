class WeathersourceTemperatureService
  attr_reader :connection, :workouts, :response

  def initialize(id)
    @workouts = User.find(id).workouts

    set_up_connection
    request_temperatures
  end

  def self.update_workouts_with_temperature(id)
    new(id)
  end

  private

  def request_temperatures
    requests = 0
    start_time = Time.now

    workouts.no_temperature.each do |workout|
      if request_limit_has_been_reached(start_time, requests)
        sleep 62
        start_time = Time.now
        requests = 0
      end

      next if workout.location.nil? || workout.location.zipcode.nil?

      requests += 1

      @response = get_api_response(workout.starting_datetime.to_json,
                                   workout.location.zipcode)

      workout.update_attribute(:temperature, temp) unless response_invalid
    end
  end

  def temp
    response[0][:temp]
  end

  def response_invalid
    response.nil? || response.empty?
  end

  def request_limit_has_been_reached(time, requests)
    Time.now - time < 60 && requests > 8
  end

  def weathersource_url
    "https://api.weathersource.com/v1/#{ENV['WEATHERSOURCE_KEY']}/history_by_postal_code.json"
  end

  def get_api_response(workout_start_time, zipcode)
    response = connection.get do |request|
      request.params["period"] = "hour"
      request.params["postal_code_eq"] = zipcode
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
