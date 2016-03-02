class AddStartingDatetimeToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :starting_datetime, :datetime
  end
end
