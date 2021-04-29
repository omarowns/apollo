module OmniauthHelper
  def find_or_create_from_omniauth(auth)
    method = "user_from_#{auth.provider}"
    send(method, auth)
  end

  def user_from_google_oauth2(auth)
    if (user = User.find_for_database_authentication(google_uid: auth.uid))
      user.google_token = auth.credentials.token
      user.google_refresh_token = auth.credentials.refresh_token
      user.save

      user
    else
      user = User.new
      user.google_uid = auth.uid
      user.google_token = auth.credentials.token
      user.google_refresh_token = auth.credentials.refresh_token
      user.name = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image
      user.save

      user
    end
  end

  def user_from_spotify(auth)
    UserFromSpotifyService.new(auth, current_user).call
  end
end
