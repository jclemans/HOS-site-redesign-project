class RemovePaperclipFromEpisode < ActiveRecord::Migration
  def self.up
    remove_column :episodes, :recording_file_name
    remove_column :episodes, :recording_content_type
    remove_column :episodes, :recording_file_size
    remove_column :episodes, :recording_updated_at
    add_column :episodes, :recording_file_name, :string
  end

  def self.down
    add_column :episodes, :recording_file_name, :string
    add_column :episodes, :recording_content_type, :string
    add_column :episodes, :recording_file_size, :string
    add_column :episodes, :recording_updated_at, :datetime
    remove_column :episodes, :recording_file_name
  end
end
