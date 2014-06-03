class HomeController < ApplicationController

  def index
    @schedules = Schedule.where(day_of_week: Date.today.wday)

  def listen_live
    render layout: 'bare'
  end
end
