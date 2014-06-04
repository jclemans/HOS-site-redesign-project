require 'hos/schedule_helpers'

class Schedule < ActiveRecord::Base
	include HOS::ScheduleHelpers
  belongs_to :program

  validate :schedule_conflicts

  def now_playing
    Schedule.where(day_of_week == Date.today.wday).each do |schedule|
      end_time = schedule.start_time + schedule.duration.to_i.minutes
      if (schedule.start_time.to_i..end_time.to_i).include?(Time.now.to_i)
        schedule.first
      end
    end
  end

  def find_next_schedule
    next_schedule = @schedules.where(start_time > Time.now).first
    if next_schedule.nil?
      next_schedule = @schedules.where(day_of_week == Date.tomorrow).first
    end
  end

  def schedule_conflicts
		first_day = if self.day_of_week == 0 then 6 else (self.day_of_week - 1) end
		last_day = (self.day_of_week + 1) % 7
		schedules = Schedule.where(day_of_week: (first_day..last_day))
		if schedules.length > 0
			existing_segments = schedules.collect(&:segments).flatten
			conflicts = self.segments & existing_segments
			if conflicts.last
				errors.add(:start_time, "Conflicts with program on #{translate_errors(conflicts)}")
			end
		end
	end

  def translate_errors(array)
  	results = []

  	array.each do |date_string|
  		number = date_string.first.to_i
  		results << "#{to_day(number)} at #{date_string.slice(2..-1)}"
  	end
  	results.join(', ')
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
	end
end
