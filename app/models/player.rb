class Player < ApplicationRecord
  belongs_to :user
  belongs_to :spotify_track, optional: true, class_name: 'Spotify::Track'
end
