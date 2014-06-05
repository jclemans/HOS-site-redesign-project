class TracksController < ApplicationController

  def create
    if Track.create(track_params)
      flash[:alert] = "Track added."
      redirect_to(:back)
    else
      flash[:alert] = "Oops, there was a problem. Try entering your track again."
      redirect_to(:back)
    end
  end

  private

  def track_params
    params.require(:track).permit(:episode_id, :content)
  end
end
