class MmfWorkoutAggregateService
  def initialize(id)
    @user = User.find(id)
    @offset = 0

    set_up_connection
    @response = get_api_response
    request_workouts
  end

  def self.new_workouts(id)
    new(id)
  end

  private

  def workout_aggregate_url
    "https://oauth2-api.mapmyapi.com/v7.1/workout/?user=#{@user.uid}"
  end

  def get_api_response(offset = 0, limit = 1)
    response = @connection.get do |request|
      request.headers["Authorization"] = "Bearer #{@user.token}"
      request.headers["Api-Key"] = ENV["MMF_API_KEY"]
      request.params["limit"] = limit
      request.params["offset"] = @offset
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def set_up_connection
    @connection = Faraday.new(:url => workout_aggregate_url) do |faraday|
      faraday.adapter Faraday.default_adapter
    end
  end

  def request_workouts
    @user.no_workouts_loaded ? load_all_workouts_from_offset : save_new_workouts
  end

  def save_new_workouts
    @offset = @user.number_of_workouts

    load_all_workouts_from_offset unless no_new_workouts
  end

  def no_new_workouts
    @response[:total_count] - @user.number_of_workouts = 0
  end

  def load_all_workouts_from_offset
    @response = get_api_response(@offset, limit = 40)
    create_workouts_from_current_response

    load_all_workouts_from_offset unless @response[:_links][:next].nil?
  end

  def create_workouts_from_current_response
    workouts.each { |data| @user.workouts.create_from_api_response(data) }

    update_offset
  end

  def update_offset
    @offset += 40
  end

  def workouts
    @response[:_embedded][:workouts]
  end
end
