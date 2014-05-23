class Schedule < ActiveRecord::Base
  belongs_to :program

  validate :schedule_conflicts

  def schedule_conflicts
    new_start_time = self.start_time
    new_duration = self.duration.minutes
    check_start_time = Schedule.all.select { |s| s.start_time < new_start_time && new_start_time < (s.start_time + s.duration.minutes) }
    if check_start_time.last
      errors.add(:start_time, "Conflicts with program #{check_start_time.last.program_id}")
    end
  end
end
