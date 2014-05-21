class User < ActiveRecord::Base

  resourcify
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  validates :phone, presence: true
  validates_uniqueness_of :phone

  validates :djname, presence: true
  validates_uniqueness_of :djname

  accepts_nested_attributes_for :roles, allow_destroy: true

end
