class Route < ActiveRecord::Base
  has_many   :workouts, dependent: :destroy
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

  def elevation_in_feet
    (elevation * 3.28084).round(2)
  end

  def update_zipcode_of_location(zipcode)
    location.update_zipcode(zipcode)
  end

  def update_local_timezone_of_location(timezone)
    location.update_local_timezone(timezone)
  end
end
