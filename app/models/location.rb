class Location < ActiveRecord::Base
  has_many :routes

  def self.create_from_api_response(data)
    Location.find_or_create_by(city: data[:city], state: data[:state])
  end

  def city_and_state
    "#{city}, #{state}"
  end

  def update_zipcode(zipcode)
    update_attribute(:zipcode, zipcode)
  end

  def update_local_timezone(timezone)
    update_attribute(:local_timezone, timezone)
  end
end
