class ProgramsController < ApplicationController
  def index
    if params.has_key? :day_of_week
      @day_of_week = Chronic.parse(params[:day_of_week]).wday
    else
      @day_of_week = Date.today.wday
    end
    @programs = Program.active.where(day_of_week: @day_of_week)
  end

  def all
  end

  def show
    @program = Program.find params[:id]
  end
  
end
