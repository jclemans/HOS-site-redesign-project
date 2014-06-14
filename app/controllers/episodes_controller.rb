class EpisodesController < ApplicationController

  def index
  end

  def new
    @user = current_user
    record_time = current_user.program.schedules.last.duration
    program_id = current_user.program.id
    @episode = Episode.new(record_time: record_time, program_id: program_id)
  end

  def create
    @episode = Episode.new(episode_params)
    if @episode.save
      flash[:alert] = "Recording in progress"
      redirect_to episode_path(@episode)
    else
      flash[:alert] = "Unable to record at this time. Please check the schedule."
    end
  end

  def show
    @episode = Episode.find(params[:id])
    @user = @episode.program.user
    @track = @episode.tracks.new
  end

  def destroy
    @episode = Episode.find(params[:id])
    @episode.destroy
    flash[:alert] = "Episode removed"
    redirect_to @episode.program
  end

  private

  def episode_params
    params.require(:episode).permit(:recorded_at, :record_time,
                                    :program_id, :title, :recording_file_name)
  end
end
