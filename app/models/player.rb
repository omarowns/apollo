class Player < ApplicationRecord
  belongs_to :user
  belongs_to :spotify_track, optional: true, class_name: 'Spotify::Track'

  after_create_commit :fetch_currently_playing
  after_update_commit :update_player_later

  private

  def update_player_later
    broadcast_replace_later_to self, :currently_playing
  end

  def fetch_currently_playing
    PlayerUpdateService.new(user).call
  end
end
