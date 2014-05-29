class User < ActiveRecord::Base
  resourcify
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :program
  
  accepts_nested_attributes_for :program, allow_destroy:  true

  validates :name, presence: true

  validates :phone, presence: true

  validates :djname, presence: true

  accepts_nested_attributes_for :roles, allow_destroy: true

  

end
