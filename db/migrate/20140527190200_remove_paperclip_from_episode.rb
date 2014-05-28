class RemovePaperclipFromEpisode < ActiveRecord::Migration
  def change
    remove_column :episodes, :recording_file_name
    remove_column :episodes, :recording_content_type
    remove_column :episodes, :recording_file_size
    remove_column :episodes, :recording_updated_at
    add_column :episodes, :recording_file_name, :string
  end
end
