class User < ApplicationRecord

  has_one :player, dependent: :destroy
  has_one :spotify_track, through: :player

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :omniauthable, omniauth_providers: %i(spotify google_oauth2)

  validates_uniqueness_of :google_uid, :email
  validates_uniqueness_of :spotify_uid, if: -> { spotify_uid.present? }

  delegate :playing, to: :player, prefix: true, allow_nil: true

  def spotify_connected?
    spotify_uid.present?
  end
end
