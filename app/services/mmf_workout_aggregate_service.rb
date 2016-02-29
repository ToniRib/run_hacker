class MmfWorkoutAggregateService
  def initialize(id)
    @user = User.find(id)
    @offset = 0

    set_up_connection
    @response = get_api_response
    request_workouts
  end

  def self.new_workouts(id)
    new(id).new_workouts
  end

  private

  def get_api_response(offset = 0)
    response = @connection.get do |request|
      request.headers["Authorization"] = "Bearer #{@user.token}"
      request.headers["Api-Key"] = ENV["MMF_API_KEY"]
      request.params["limit"] = 40
      request.params["offset"] = @offset
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  def set_up_connection
    @connection = Faraday.new(:url => "https://oauth2-api.mapmyapi.com/v7.1/workout/?user=#{@user.uid}") do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end

  def request_workouts
    @user.no_workouts_loaded ? load_all_workouts : save_new_workouts
  end

  def save_new_workouts
    number_of_new_workouts = @response[:total_count] - @user.number_of_workouts
    # somehow use background worker to load new workouts?
    # cycle through requests to load all new workouts using offset & limit
    # hit specific workout endpoint to load starting position, lat, and long (maybe also end?)
    # hit weather API to get temperature at start of run (maybe also middle & end?)
  end

  def load_all_workouts
    # make this recursive and pass in next_flag
    create_workouts_from_current_response

    next_flag = false

    until next_flag do
      @response = get_api_response(@offset)

      create_workouts_from_current_response

      next_flag = true if @response[:_links][:next].nil?
    end
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
