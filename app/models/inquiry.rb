class Inquiry < ActiveRecord::Base
  include AntiSpamValidations

  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :message, presence: true

end
