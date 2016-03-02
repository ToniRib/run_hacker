class Route < ActiveRecord::Base
  has_many   :workouts
  belongs_to :location

  scope :no_elevation, -> { where(elevation: nil) }

  def self.create_from_api_response(data)
    location = Location.find_by(city: data[:city], state: data[:state])

    Route.create(location_id:        location.id,
                 starting_longitude: data[:starting_location][:coordinates][0],
                 starting_latitude:  data[:starting_location][:coordinates][1]
    )
  end
end
