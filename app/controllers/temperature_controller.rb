class TemperatureController < ApplicationController
  def index
    @workouts = current_user.workouts.distance_temperature_and_total_time
  end
end
