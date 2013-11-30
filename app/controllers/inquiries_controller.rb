class InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.create(inquiry_params)

    if @inquiry.valid?
      redirect_to new_inquiry_path, notice: t('inquiries.thank_you')
    else
      render action: :new
    end
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:name, :email, :subject, :message, :blue_meanies)
  end
end
