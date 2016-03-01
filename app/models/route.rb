class Route < ActiveRecord::Base
  has_many :workouts

  scope :no_elevation, -> { where(elevation: nil) }

  def self.create_from_api_response(data)
    Route.create(city: data[:city],
                 state: data[:state],
                 starting_longitude: data[:starting_location][:coordinates][0],
                 starting_latitude: data[:starting_location][:coordinates][1]
    )
  end
end
