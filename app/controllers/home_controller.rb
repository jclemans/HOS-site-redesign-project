class HomeController < ApplicationController
  def index
    @schedules = Schedule.where(day_of_week: Date.today.wday)
  end

  def listen_live
    render layout: 'bare'
  end

  def index
  end
end
