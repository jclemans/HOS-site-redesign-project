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
    @user = User.find(@program.user_id)
  end

  def edit
    @program = Program.find params[:id]
  end

  def update
    @program = Program.find params[:id]
      if @program.update(program_params)
        redirect_to program_path(@program)
        flash[:alert] = "Update successful."
      else
        render program_path(@program)
        flash[:alert] = "Update unsuccesful."
      end
  end

private
  def program_params
    params.require(:program).permit(:name, :description, :avatar)
  end

end
