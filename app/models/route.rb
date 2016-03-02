class Route < ActiveRecord::Base
  has_many   :workouts
  belongs_to :location

  scope :no_elevation, -> { where(elevation: nil) }

  def self.create_from_api_response(data, location_id)
    Route.create(starting_longitude: data[:starting_location][:coordinates][0],
                 starting_latitude:  data[:starting_location][:coordinates][1],
                 location_id:        location_id)
  end

  def update_elevation(elevation)
    update_attribute(:elevation, elevation)
  end
end
