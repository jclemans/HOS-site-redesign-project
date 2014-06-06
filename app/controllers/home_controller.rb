class HomeController < ApplicationController

<<<<<<< HEAD
<<<<<<< HEAD
  def index
    @schedules = Schedule.where(day_of_week: Date.today.wday)
=======
  # def index
  #   @schedules = Schedule.where(day_of_week: Date.today.wday)
  # end
>>>>>>> rewrites and refactors the now playing functionality in two methods, appropriate tests and display
=======
  # def index
  #   @schedules = Schedule.where(day_of_week: Date.today.wday)
  # end
>>>>>>> 1582b0ca2182831b55d6d9b642bc0797a312f697

  def listen_live
    render layout: 'bare'
  end
end
