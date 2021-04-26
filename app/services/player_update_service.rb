class PlayerUpdateService
  def initialize(user)
    @user = user
    @service = SpotifyService.new(user: @user)
  end

  def call
    if @service.is_playing?
      track = Spotify::Track.find_or_initialize_by_uri(@service.currently_playing)
      track.save unless track.persisted?

      @user.player.update(spotify_track: track, playing: true)
    else
      @user.player.update(playing: false)
    end
    enqueue_next
  end

  def enqueue_next
    if @service.is_playing?
      track_duration = @service.currently_playing.duration_ms
      track_progress = @service.player.progress
      remaining_seconds = (track_duration - track_progress) / 1000
      enqueue_after = remaining_seconds + 5

      UserUpdatePlayerJob.set(wait: enqueue_after.seconds).perform_later(@user)
    end
  end
end
