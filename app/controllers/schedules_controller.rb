require 'hos/schedule_helpers'
class SchedulesController < ApplicationController

  load_and_authorize_resource

  def index
    @schedules = Schedule.all.decorate.inject({}) do |days, schedule|
      days[schedule.day_of_week] ||= []
      days[schedule.day_of_week] << schedule
      days
    end
  end
end
