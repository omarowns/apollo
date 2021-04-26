class CreateSpotifyTracks < ActiveRecord::Migration[6.1]
  def change
    create_table :spotify_tracks do |t|
      t.string :uri
      t.string :artist
      t.string :artist_url
      t.string :album
      t.string :album_url
      t.string :song
      t.string :song_url
      t.string :album_cover_url
      t.string :preview_url

      t.timestamps
    end
    add_index :spotify_tracks, :uri, unique: true
  end
end
