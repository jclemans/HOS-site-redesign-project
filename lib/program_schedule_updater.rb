class ProgramScheduleUpdater

  def self.run_all
    Program.all.each do |p|
      day_of_week = p.day_of_week
      id = p.id
      unless p.start_hour.nil? || p.start_minute.nil? || day_of_week.nil? || p.end_hour.nil? || p.end_minute.nil? || p.is_active == false
        start_time = p.start_hour + ":" + p.start_minute
        end_time = p.end_hour + ":" + p.end_minute
        if end_time.to_time < start_time.to_time
          end_time = "24:00"
        end
        duration = (end_time.to_time - start_time.to_time) / 3600 * 60

        schedule = Schedule.create(:program_id => id, :start_time => start_time, :duration => duration, :day_of_week => day_of_week)
      end
    end
  end
end

