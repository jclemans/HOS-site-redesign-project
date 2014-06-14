class ScheduleDecorator < Draper::Decorator
  delegate_all
  
  def show_time
    "#{object.start_time.strftime("%l:%M%P")} - #{(object.start_time + object.duration.minutes).strftime("%l:%M%P")}"
  end

end