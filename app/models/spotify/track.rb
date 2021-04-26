class Spotify::Track < ApplicationRecord
  has_many :players

  validates_uniqueness_of :uri

  def self.find_or_initialize_by_uri(rspotify_track)
    find_by(uri: rspotify_track.uri) || self.from(rspotify_track)
  end

  def self.from(rspotify_track)
    new(
      uri: rspotify_track.uri,
      artist: rspotify_track.album.artists.first.name,
      artist_url: rspotify_track.album.artists.first.external_urls['spotify'],
      album: rspotify_track.album.name,
      album_url: rspotify_track.album.external_urls['spotify'],
      song: rspotify_track.name,
      song_url: rspotify_track.external_urls['spotify'],
      album_cover_url: rspotify_track.album.images.find { |img| img['height'] == 300 }['url'],
      preview_url: rspotify_track.preview_url
    )
  end

  def spotify_id
    uri.split(':').last
  end
end
