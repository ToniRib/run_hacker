class AddLocalTimezoneToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :local_timezone, :string
  end
end
