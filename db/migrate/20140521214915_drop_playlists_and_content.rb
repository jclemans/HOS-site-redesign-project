class DropPlaylistsAndContent < ActiveRecord::Migration
  def change
  	drop_table :playlists 
  	drop_table :contents 

  	create_table :tracks do |t|
  		t.string :content
  		t.integer :episode_id 
  		t.timestamps
  	end
  end
end