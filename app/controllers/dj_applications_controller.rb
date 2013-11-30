class DjApplicationsController < ApplicationController
  def new
    @dj_application = DjApplication.new
  end

  def create
    @dj_application = DjApplication.create dj_app_params
    if @dj_application.valid?
      redirect_to new_dj_application_path, notice: "Thank you.  Your application has been submitted, and will be reviewed soon.  We look forward to talking with you."
    else
      render action: :new
    end
  end

  private
  def dj_app_params
    params.require(:dj_application).permit(:name, :email, :phone, :show_description, :show_name, :dj_name, :is_cost_ok, :availability, :internal_contacts, :blue_meanies)
  end
end
