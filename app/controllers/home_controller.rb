class HomeController < ApplicationController
  def index
    @schedules = Schedule.where(day_of_week: Date.today.wday)
  end

<<<<<<< HEAD
  def index
    @schedules = Schedule.where(day_of_week: Date.today.wday)
=======
  # def index
  #   @schedules = Schedule.where(day_of_week: Date.today.wday)
  # end
>>>>>>> rewrites and refactors the now playing functionality in two methods, appropriate tests and display

  def listen_live
    render layout: 'bare'
  end
end
