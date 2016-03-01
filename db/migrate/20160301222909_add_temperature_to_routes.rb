class AddTemperatureToRoutes < ActiveRecord::Migration
  def change
    add_column :workouts, :temperature, :float
  end
end
