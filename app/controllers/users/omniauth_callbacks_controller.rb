# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OmniauthHelper
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def spotify
    user_from_omniauth do
      set_flash_message(:notice, :success, kind: 'Spotify') if is_navigational_format?
    end
  end

  def google_oauth2
    user_from_omniauth do
      set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
    end
  end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end

  private

  def user_from_omniauth
    @user = find_or_create_from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
      yield
    else
      redirect_to new_user_session_path
    end
  end
end
