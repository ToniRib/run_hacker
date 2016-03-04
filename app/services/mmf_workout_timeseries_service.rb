class MmfWorkoutTimeseriesService
  attr_reader :map_my_fitness_id, :connection, :user

  def initialize(map_my_fitness_id, user)
    @map_my_fitness_id = map_my_fitness_id
    @user = user

    set_up_connection
  end

  def get_timeseries
    WorkoutTimeseries.new(get_api_response)
  end

  private

  def workout_timeseries_url
    "https://oauth2-api.mapmyapi.com/v7.1/workout/#{@map_my_fitness_id}"
  end

  def get_api_response
    response = connection.get do |request|
      request.headers["Authorization"] = "Bearer #{@user.token}"
      request.headers["Api-Key"] = ENV["MMF_API_KEY"]
      request.params["field_set"] = "time_series"
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def set_up_connection
    @connection = Faraday.new(url: workout_timeseries_url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end
end
