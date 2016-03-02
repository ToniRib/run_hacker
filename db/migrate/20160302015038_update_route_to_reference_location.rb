class UpdateRouteToReferenceLocation < ActiveRecord::Migration
  def change
    remove_column :routes, :city
    remove_column :routes, :state
    add_reference :routes, :location, index: true, foreign_key: true
  end
end
