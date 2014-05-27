class EpisodesController < ApplicationController

	def index
  end

	def new
		@episode = Episode.new
  end

  def create
    @user = User.find(current_user)
    @episode = Episode.create
    redirect_to user_path(current_user)
  end

end
