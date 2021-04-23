class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable, :omniauthable, omniauth_providers: %i(spotify)

  validates_uniqueness_of :uid
  validates_uniqueness_of :email
end
