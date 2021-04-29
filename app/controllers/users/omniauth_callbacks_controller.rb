# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OmniauthHelper
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  def spotify
    user_from_omniauth('Spotify')
  end

  def google_oauth2
    user_from_omniauth('Google')
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

  def user_from_omniauth(kind)
    if closed_registration? && spotify_user_exists?
      reason = "another account is already connected with your Spotify account"
      additional_message = "Contact your admin to have that account deleted."

      flash[:alert] = []
      flash[:alert] << find_message(:failure, kind: kind, reason: reason) if is_navigational_format?
      flash[:alert] << find_message(:message, message: additional_message) if is_navigational_format?

      redirect_to root_path and return
    end

    @user = find_or_create_from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
    else
      redirect_to new_user_session_path
    end
  end

  def spotify_user_exists?
    User.find_for_database_authentication(spotify_uid: request.env['omniauth.auth'].uid).present?
  end

  def closed_registration?
    !open_registration?
  end

  def open_registration?
    ENV.fetch('OPEN_REGISTRATION') { false }
  end
end
