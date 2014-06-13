class HomeController < ApplicationController
  def index
    @now_playing = Schedule.now_playing(Time.now)
    @next_up = Schedule.find_next_schedule
    render layout: 'home'
  end

  def listen_live
    render layout: 'bare'
  end
end
