class EpisodesController < ApplicationController

	def index
  end

	def new
		@episode = Episode.new
  end

  def create
    @episode = Episode.create
  end

end
