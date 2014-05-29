class AddRecordingToEpisode < ActiveRecord::Migration
  def self.up
    add_attachment :episodes, :recording
  end

  def self.down
    remove_attachment :episodes, :recording
  end
end