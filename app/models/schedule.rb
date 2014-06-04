
require 'hos/schedule_helpers'

class Schedule < ActiveRecord::Base
	include HOS::ScheduleHelpers
  belongs_to :program

  validate :schedule_conflicts

  def self.now_playing(time_to_check)
    result = nil
    schedules = Schedule.where(day_of_week: time_to_check.wday)
    schedules.each do |schedule|
      rounded_time = Time.at((time_to_check.to_f / 1800).round * 1800)
      this_schedule_intersection = schedule.segments & [schedule.segment_format(time_to_check.wday, rounded_time)]
      if this_schedule_intersection.length != 0
        result = schedule
      end
      result
    end
  end

  def self.find_next_schedule
    next_time = Time.now + 30.minutes
    next_show = Schedule.now_playing(next_time)
    while next_show == nil && next_time < Time.now + 7.days
      next_time = next_time + 30.minutes 
      next_show = Schedule.now_playing(next_time)
    end
    if next_show != nil
      next_show
    else 
      nil
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
			results << segment_format(segment_day, segment_time)
		end
		results
	end

  def segment_format(weekday, time)
    "#{weekday}-#{time.strftime('%H:%M')}"
  end
end
