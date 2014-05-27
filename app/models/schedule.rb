class Schedule < ActiveRecord::Base
  belongs_to :program

  validate :schedule_conflicts

  def schedule_conflicts
    new_start_time = self.start_time
    new_duration = self.duration.minutes
    days = self.days_of_week
    result = []

    Schedule.all.each do |schedule|
      schedule.days_of_week.each do |existing_schedule_day|
        days.each do |new_schedule_day|
          if existing_schedule_day == new_schedule_day && schedule.start_time <= new_start_time && new_start_time <= (schedule.start_time + schedule.duration.minutes)
            result << schedule
          end
        end
      end
    end


    if result.last
      errors.add(:start_time, "Conflicts with program #{result.last.program_id}")
    end
  end
end
