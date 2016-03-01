class Workout < ActiveRecord::Base
  belongs_to :user
  belongs_to :route

  scope :no_temperature, -> { where(temperature: nil) }

  def self.create_from_api_response(data)
    return if data[:aggregates][:distance_total] == 0

    Workout.create(created_at: data[:created_datetime],
                   updated_at: data[:updated_datetime],
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
end
