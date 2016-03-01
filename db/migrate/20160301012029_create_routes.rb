class CreateRoutes < ActiveRecord::Migration
  def change
    create_table :routes do |t|
      t.references :workout, index: true, foreign_key: true
      t.string :city
      t.string :state
      t.float :starting_latitude
      t.float :starting_longitude

      t.timestamps null: false
    end
  end
end
