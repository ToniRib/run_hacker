class AddLocalTimezoneToWorkouts < ActiveRecord::Migration
  def change
    add_column :workouts, :local_timezone, :string
  end
end
