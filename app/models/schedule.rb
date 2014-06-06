<<<<<<< HEAD
require 'hos/date_helpers'

=======
require 'hos/schedule_helpers'
>>>>>>> 33db13d3c9048b5afac27bca2dc6d38faeb25a4c
class Schedule < ActiveRecord::Base
	include HOS::ScheduleHelpers
  belongs_to :program

  validate :schedule_conflicts

  def self.now_playing
    result = nil
    schedules = Schedule.where(day_of_week: Date.today.wday)

    schedules.each do |schedule|
      rounded_time = Time.at((Time.now.to_f / 1800).round * 1800)
      this_one = schedule.segments & [schedule.segment_key(Date.today.wday, rounded_time)]
      if this_one.length != 0
        result = schedule
      end
    end
    result
  end

  def self.find_next_schedule(day)
    search_day = Date.today + day.days
    schedule = Schedule.where(day_of_week: search_day.wday).where("start_time > ?", Time.new(2000)).first
    binding.pry
    if schedule != nil
      schedule
    elsif day > 7
      return "There are no programs scheduled for the next week. Contact an adminstrator."
    else 
      self.find_next_schedule(day+1)
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
			results << segment_key(segment_day, segment_time)
		end
		results
	end

  def segment_key(weekday, time)
    "#{weekday}-#{time.strftime('%H:%M')}"
  end
end
