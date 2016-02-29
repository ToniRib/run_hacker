class MmfWorkoutAggregateService
  def self.new_workouts(id)
    @user = User.find(id)
    set_up_connection

    raw_response = @connection.get do |request|
      request.headers["Authorization"] = "Bearer #{@user.token}"
      request.headers["Api-Key"] = ENV["MMF_API_KEY"]
    end

    @response = JSON.parse(raw_response.body, symbolize_names: true)

    request_workouts
  end

  private

  def self.set_up_connection
    @connection = Faraday.new(:url => "https://oauth2-api.mapmyapi.com/v7.1/workout/?user=#{@user.uid}") do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end

  def self.request_workouts
    @user.no_workouts_loaded ? load_all_workouts : save_new_workouts
  end

  def self.save_new_workouts
    number_of_new_workouts = @response[:total_count] - @user.number_of_workouts
    # somehow use background worker to load new workouts?
    # cycle through requests to load all new workouts using offset & limit
    # hit specific workout endpoint to load starting position, lat, and long (maybe also end?)
    # hit weather API to get temperature at start of run (maybe also middle & end?)
  end

  def self.load_all_workouts
    # save the current list of workouts from the response then,
    # need stuff here to be able to load ALL workouts by changing offset & limit
    # until there are no more workouts left to grab
    # probably will want this in a background worker
  end
end
