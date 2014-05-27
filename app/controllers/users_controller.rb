class UsersController < ApplicationController

  load_and_authorize_resource

  def show
    @user = User.find(params[:id])
    @episode = Episode.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to user_path(@user)
        flash[:alert] = "Update successful."
      else
        redirect_to user_path(@user)
        flash[:alert] = "Update not applied"
      end
  end

private
  def user_params
    params.require(:user).permit(:name, :email, :djname, :phone)
  end
end

