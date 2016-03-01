class MmfRouteService
  attr_reader :user, :offset, :response, :connection

  def initialize(id)
    @user = User.find(id)
    @offset = 0

    set_up_connection
    @response = get_api_response
    request_routes
  end

  def self.load_routes(id)
    new(id)
  end

  private

  def workout_aggregate_url
    "https://oauth2-api.mapmyapi.com/v7.1/route/?user=#{@user.uid}"
  end

  def get_api_response(offset = 0, limit = 1)
    response = connection.get do |request|
      request.headers["Authorization"] = "Bearer #{@user.token}"
      request.headers["Api-Key"] = ENV["MMF_API_KEY"]
      request.params["limit"] = limit
      request.params["offset"] = offset
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def set_up_connection
    @connection = Faraday.new(:url => workout_aggregate_url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def request_routes
    user.no_routes_loaded ? load_all_routes_from_offset : save_new_routes
  end

  def save_new_routes
    @offset = user.number_of_routes

    load_all_routes_from_offset unless no_new_routes
  end

  def no_new_routes
    response[:total_count] - user.number_of_routes == 0
  end

  def load_all_routes_from_offset
    @response = get_api_response(offset, limit = 40)
    create_routes_from_current_response

    load_all_routes_from_offset unless no_additional_routes_available
  end

  def no_additional_routes_available
    response[:_links][:next].nil?
  end

  def create_routes_from_current_response
    routes.each do |data|
      route = Route.create_from_api_response(data)

      workouts_with_corresponding_route_id(data).each do |workout|
        workout.update_attribute(:route_id, route.id)
      end
    end

    update_offset
  end

  def workouts_with_corresponding_route_id(data)
    user.workouts.where(map_my_fitness_route_id: route_id(data))
  end

  def route_id(data)
    data[:_links][:self][0][:id]
  end

  def update_offset
    @offset += 40
  end

  def routes
    response[:_embedded][:routes]
  end
end
