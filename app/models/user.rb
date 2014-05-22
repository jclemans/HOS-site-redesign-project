class User < ActiveRecord::Base
  belongs_to :program
  resourcify
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  validates :phone, presence: true

  validates :djname, presence: true

  accepts_nested_attributes_for :roles, allow_destroy: true

  has_one :program

end
