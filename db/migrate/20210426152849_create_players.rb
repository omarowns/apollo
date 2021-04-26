class CreatePlayers < ActiveRecord::Migration[6.1]
  def change
    create_table :players do |t|
      t.references :user, null: false, foreign_key: true
      t.references :spotify_track, null: true, foreign_key: true
      t.boolean :playing, default: false

      t.timestamps
    end
  end
end
