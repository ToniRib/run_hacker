class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.string :city
      t.string :state
      t.float :starting_latitude
      t.float :starting_longitude

      t.timestamps null: false
    end
  end
end
