class ChangeOmniauthColumnsOnUsers < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, :uid, unique: true
    remove_column :users, :uid, :spotify_uid
    add_column :users, :spotify_uid, :string, null: true
    add_index :users, :spotify_uid, unique: true
    rename_column :users, :token, :spotify_token
    rename_column :users, :refresh_token, :spotify_refresh_token

    add_column :users, :google_uid, :string
    add_index :users, :google_uid
    add_column :users, :google_token, :string
    add_column :users, :google_refresh_token, :string
  end
end
