class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.integer :map_my_fitness_id
      t.boolean :has_time_series
      t.float :distance
      t.float :average_speed
      t.float :active_time
      t.float :elapsed_time
      t.float :metabolic_energy
      t.integer :map_my_fitness_route_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
