class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :token
      t.string :provider
      t.integer :uid
      t.string :display_name
      t.string :username
      t.string :email
      t.string :image

      t.timestamps null: false
    end
  end
end
