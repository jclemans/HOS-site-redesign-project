class Schedule < ActiveRecord::Base
  belongs_to :program

  before_create :validate_program_create

  def find_end_time
    start = DateTime.parse(start_time)
    duration = duration.minutes
    end_time = start + duration
  end

  def validate_program_create(new_start_time, duration)
    previous_program = Program.where("start_time < new_start_time").order("start_time ASC").last
    next_program = Program.where("start_time > new_start_time").order("start_time ASC").first

    if new_start_time < previous_program.find_end_time || new_start_time + duration > next_program.start_time
      flash[:alert] = "There is a conflict with the schedule. Please try again."
      return false
    else
      Schedule.create()
    end
  end

private
  def schedule_params
    params.require(:schedule).permit(:start_time, :duration, :days_of_week)
  end
end
