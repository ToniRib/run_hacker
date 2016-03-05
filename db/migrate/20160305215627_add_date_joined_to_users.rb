class AddDateJoinedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_joined, :datetime
  end
end
