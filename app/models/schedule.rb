class Schedule < ActiveRecord::Base
  belongs_to :program

  validate :schedule_conflicts

  def schedule_conflicts
    new_start_time = self.start_time
    new_duration = self.duration.minutes
    new_day = self.day_of_week
    start_conflicts = checker(new_start_time, new_day)
    if
      errors.add(:start_time, "Conflicts with program #{start_conflicts.last.program_id}")
    end
  end

  def checker(new_start_time, new_day)
    result = []
    Schedule.all.each do |schedule|
      if schedule.day_of_week == new_day && schedule.start_time <= new_start_time && new_start_time <= (schedule.start_time + schedule.duration.minutes)
        result << schedule
      end
    end
    result
  end

  def segments
    results = []
    (0...self.duration).step(30) do |n|
      segment_time = self.start_time + n.minutes
      if segment_time.wday != self.start_time.wday
        segment_day = (self.day_of_week + 1) % 7
      else
        segment_day = self.day_of_week
      end
      results << "#{segment_day}-#{segment_time.strftime('%H:%M')}"
    end
    results
    # self.start_time
  end

  # schedules = Schedule.where(day_of_week:[(new_day-1)..(new_day + 1)])
  # existing_segments = schedules.collect(&:segments).flatten
  #  do an intersection of these two arrays to see if there is an overlap
end


