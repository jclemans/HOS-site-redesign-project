class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  check_authorization
  
  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.has_role? :admin
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  include ProgramStats
  helper_method :program_count
end
