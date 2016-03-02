class Route < ActiveRecord::Base
  has_many   :workouts
  belongs_to :location

  scope :no_elevation, -> { where(elevation: nil) }
  scope :no_location, -> { where(location_id: nil) }

  def self.create_from_api_response(data)
    route = Route.create(starting_longitude: data[:starting_location][:coordinates][0],
                         starting_latitude:  data[:starting_location][:coordinates][1]
    )

    location = Location.find_by(city: data[:city], state: data[:state])
    route.update_attribute(:location_id, location.id) if location

    route
  end
end
