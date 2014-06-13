class Program < ActiveRecord::Base
  belongs_to :user
  has_many :schedules
  has_many :episodes, -> { order 'recorded_at desc'}, dependent: :destroy
  accepts_nested_attributes_for :episodes, allow_destroy:  true
  accepts_nested_attributes_for :schedules, allow_destroy: true

  has_attached_file :avatar, styles: {huge: '600x600', large: '400x400', medium: '200x200', thumb: '50x50'}
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :avatar, :in => 0.megabytes..2.megabytes
  validates :user_id, presence: true
  scope :active, -> {where is_active: true}
<<<<<<< HEAD
end
=======
end
>>>>>>> 364e0ddd4abe7320b487dbf992ca03bd41f9974f
