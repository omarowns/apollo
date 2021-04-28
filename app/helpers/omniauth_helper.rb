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
    return User.new unless current_user

    current_user.spotify_uid = auth.uid
    current_user.spotify_token = auth.credentials.token
    current_user.spotify_refresh_token = auth.credentials.refresh_token
    current_user.nickname = auth.info.nickname
    current_user.image = auth.info.image unless current_user.image.present?
    current_user.url = auth.info.urls.symbolize_keys[:spotify]
    current_user.save
    current_user.create_player

    current_user
  end
end
