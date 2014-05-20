class AddPlaylistsAndSongs < ActiveRecord::Migration
  def change
  	create_table :playlists do |t|
  		t.integer :episode_id
  		t.integer :content_id
  	end

  	create_table :contents do |t|
  		t.string :name
  		t.string :artist
  	end
  end
end