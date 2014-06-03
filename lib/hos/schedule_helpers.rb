module HOS
  module ScheduleHelpers

    def to_day(number)
      days = { 'Sunday' => 0, 'Monday' => 1, 'Tuesday' => 2, 'Wednesday' => 3, 'Thursday' => 4, 'Friday' => 5, 'Saturday' => 6}
      days.key(number)
    end

    def day_total(schedules)
      durations =  schedules.collect do |schedule|
        schedule.duration
      end
      durations.sum
    end

    def calc_schedule_percent(duration, schedules)
      day_duration = day_total(schedules)
      duration / day_duration * 100
    end
  end
end
