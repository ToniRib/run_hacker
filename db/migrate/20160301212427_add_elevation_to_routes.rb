class AddElevationToRoutes < ActiveRecord::Migration
  def change
    add_column :routes, :elevation, :float
  end
end
