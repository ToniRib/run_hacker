class Route < ActiveRecord::Base
  belongs_to :workout

  def self.create_from_api_response(data, workout_id)
    Route.create(workout_id: workout_id,
                 city: data[:city],
                 state: data[:state],
                 starting_longitude: data[:starting_location][:coordinates][0],
                 starting_latitude: data[:starting_location][:coordinates][1]
    )
  end
end
