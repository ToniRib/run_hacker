class Workout < ActiveRecord::Base
  belongs_to :user
  belongs_to :route
  has_one    :location, through: :route

  scope :no_temperature, -> { where(temperature: nil) }

  def self.create_from_api_response(data)
    return if data[:aggregates][:distance_total] == 0

    Workout.create(starting_datetime: data[:created_datetime],
                   map_my_fitness_id: data[:_links][:self][0][:id],
                   has_time_series: data[:has_time_series],
                   distance: data[:aggregates][:distance_total],
                   average_speed: data[:aggregates][:speed_avg],
                   active_time: data[:aggregates][:active_time_total],
                   elapsed_time: data[:aggregates][:elapsed_time_total],
                   metabolic_energy: data[:aggregates][:metabolic_energy_total],
                   map_my_fitness_route_id: data[:_links][:route][0][:id]
    )
  end

  def update_temperature(temp)
    update_attribute(:temperature, temp)
  end

  def starting_date_in_iso_format
    starting_datetime.localtime.strftime("%Y-%m-%-dT%H:%M")
  end

  def self.distance_temperature_and_total_time
    pluck(:distance, :temperature, :elapsed_time).delete_if { |set| set.any?(&:nil?) }
  end

  # def self.temperature_v_distance_data(min, max)
  #   where("distance BETWEEN ? AND ?", min, max).pluck(:temperature, :distance)
  # end
end
