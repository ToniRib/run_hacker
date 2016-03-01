class MmfRouteService
  attr_reader :user, :response, :connection

  def initialize(id)
    @user = User.find(id)

    request_routes
  end

  def self.load_corresponding_route_info(id)
    new(id)
  end

  private

  def request_routes
    user.workouts.each do |workout|
      url = route_url(workout.map_my_fitness_route_id)
      set_up_connection(url)
      response = get_api_response

      Route.create_from_api_response(response, workout.id)
    end
  end

  def set_up_connection(url)
    @connection = Faraday.new(:url => url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def route_url(route_id)
    "https://oauth2-api.mapmyapi.com/v7.1/route/#{route_id}/?format=json"
  end

  def get_api_response
    response = connection.get do |request|
      request.headers["Authorization"] = "Bearer #{@user.token}"
      request.headers["Api-Key"] = ENV["MMF_API_KEY"]
    end

    JSON.parse(response.body, symbolize_names: true)
  end
end
