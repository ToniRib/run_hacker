class AddRouteIdToWorkouts < ActiveRecord::Migration
  def change
    add_reference :workouts, :route, index: true, foreign_key: true
  end
end
