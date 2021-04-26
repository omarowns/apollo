class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = ::User.joins(player: :spotify_track).all
  end
end
