class SchedulesController < ApplicationController

  load_and_authorize_resource

  def index
    @schedules = Schedule.all.inject({}) do |h, schedule|
      h[schedule.day_of_week] ||= []
      h[schedule.day_of_week] << schedule
      h
    end
  end

end

# h.sort_by { |k,v| v[:day_of_week] }
