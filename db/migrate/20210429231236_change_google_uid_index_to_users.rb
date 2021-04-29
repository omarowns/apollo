class ChangeGoogleUidIndexToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_index :users, :google_uid, unique: true
    remove_column :users, :google_uid, :spotify_uid
    add_column :users, :google_uid, :string, null: true
    add_index :users, :google_uid, unique: true
  end
end
