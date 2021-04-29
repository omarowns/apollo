class UserFromSpotifyService
  def initialize(auth, current_user = nil)
    @auth = auth
    @current_user = current_user
    @open_registration = ENV.fetch('OPEN_REGISTRATION') { false }
  end

  def call
    if @open_registration
      find_or_create_from_omniauth
    else
      set_from_omniauth
    end
  end

  private

  def find_or_create_from_omniauth
    if (user = User.find_for_database_authentication(spotify_uid: @auth.uid))
      user.spotify_token = @auth.credentials.token
      user.spotify_refresh_token = @auth.credentials.refresh_token
      user.save!

      user
    else
      user = User.new
      user.spotify_uid = @auth.uid
      user.spotify_token = @auth.credentials.token
      user.spotify_refresh_token = @auth.credentials.refresh_token
      user.name = @auth.info.name
      user.email = @auth.info.email
      user.nickname = @auth.info.nickname
      user.image = @auth.info.image
      user.url = @auth.info.urls.symbolize_keys[:spotify]
      user.save!
      user.create_player if user.persisted?

      user
    end
  end

  def set_from_omniauth
    return User.new unless @current_user

    @current_user.spotify_uid = @auth.uid
    @current_user.spotify_token = @auth.credentials.token
    @current_user.spotify_refresh_token = @auth.credentials.refresh_token
    @current_user.nickname = @auth.info.nickname
    @current_user.image = @auth.info.image unless @current_user.image.present?
    @current_user.url = @auth.info.urls.symbolize_keys[:spotify]
    @current_user.save!
    @current_user.create_player if @current_user.persisted?

    @current_user
  end
end
