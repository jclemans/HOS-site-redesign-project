class DjApplication < ActiveRecord::Base
  include AntiSpamValidations


  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i }
  validates :name, presence: true
  validates :phone, presence: true
  validates :show_description, presence: true
  validates :show_name, presence: true
  validates :dj_name, presence: true
  validates :is_cost_ok, presence: true
  validates :availability, presence: true
  validates :internal_contacts, presence: true

end
