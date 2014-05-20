class AddAttachmentAvatarToPrograms < ActiveRecord::Migration
  def self.up
    change_table :programs do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :programs, :avatar
  end
end
