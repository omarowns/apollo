module OmniauthHelper
  def find_or_create_from_omniauth(auth)
    if (user = User.find_for_database_authentication(uid: auth.uid))
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.save

      user
    else
      user = User.new
      user.uid = auth.uid
      user.token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.name = auth.info.name
      user.nickname = auth.info.nickname
      user.email = auth.info.email
      user.image = auth.info.image
      user.url = auth.info.urls.symbolize_keys[:spotify]
      user.save
      user.create_player

      user
    end
  end
end
