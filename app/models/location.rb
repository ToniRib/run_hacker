class Location < ActiveRecord::Base
  has_many :routes

  def self.create_from_api_response(data)
    Location.create(city: data[:city], state: data[:state])
  end
end
