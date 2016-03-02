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
      if Time.now - start_time < 60 && requests > 9
        sleep 60
        start_time = Time.now
        requests = 0
      end

      requests += 1

      @response = get_api_response(workout.starting_datetime.to_json,
                                   workout.location.zipcode)

      workout.update_attribute(:temperature, temperature) unless response.nil?
    end
  end

  def temperature
    response[0][:temp]
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
