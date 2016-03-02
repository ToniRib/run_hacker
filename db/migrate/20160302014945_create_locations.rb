class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :city
      t.string :state
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
