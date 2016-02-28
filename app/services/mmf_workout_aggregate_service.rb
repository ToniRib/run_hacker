class MmfWorkoutAggregateService
  def self.new_workouts(uid, token, id)
    set_up_connection(uid)

    response = @connection.get do |request|
      request.headers["Authorization"] = "Bearer #{token}"
      request.headers["Api-Key"] = ENV["MMF_API_KEY"]
    end

    save_new_workouts(JSON.parse(response.body, symbolize_names: true), id)
  end

  private

  def self.set_up_connection(uid)
    @connection = Faraday.new(:url => "https://oauth2-api.mapmyapi.com/v7.1/workout/?user=#{uid}") do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end

  def self.save_new_workouts(response, id)
    user = User.find(id)
    number_of_new_workouts = response[:total_count] - user.workouts.count
    # somehow use background worker to load new workouts?
  end
end
