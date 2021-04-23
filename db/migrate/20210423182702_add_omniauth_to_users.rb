class AddOmniauthToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string, null: false
    add_index :users, :uid, unique: true
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :image, :string
    add_column :users, :url, :string
    add_column :users, :token, :string
    add_column :users, :refresh_token, :string
  end
end
