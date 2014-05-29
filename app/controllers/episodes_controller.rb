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
    if Episode.create(episode_params)
      flash[:alert] = "Recording in progress"
      redirect_to root_path
    else
      flash[:alert] = "Unable to record at this time. Please check the schedule."
    end
  end

  private

  def episode_params
    params.require(:episode).permit(:recorded_at, :record_time,
                                    :program_id, :title, :recording_file_name)
  end
end
