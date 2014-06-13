class HomeController < ApplicationController
  def index
    @now_playing = Schedule.now_playing(Time.now)
    @now_playing = @now_playing.decorate if @now_playing
    @next_up = Schedule.find_next_schedule
    @next_up = @next_up.decorate if @next_up
    render layout: 'home'
  end

  def listen_live
    render layout: 'bare'
  end
end
