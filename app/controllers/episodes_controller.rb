class EpisodesController < ApplicationController

  def index
  end

  def new
    @user = current_user
    @episode = Episode.new
  end

  def create
    @episode = Episode.create
    redirect_to user_path(current_user)
  end
end
