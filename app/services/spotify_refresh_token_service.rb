class SpotifyRefreshTokenService
  def self.callback(user)
    Proc.new do |new_access_token, token_lifetime|
      now = Time.now.utc.to_i
      deadline = now + token_lifetime
      user.update(spotify_token: new_access_token)
    end
  end
end
