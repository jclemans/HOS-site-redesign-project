require 'download_photos'

class AvatarMigration < ActiveRecord::Migration
  def change
    DownloadPhotos.run_all
  end
end

