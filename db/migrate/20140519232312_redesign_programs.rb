class RedesignPrograms < ActiveRecord::Migration
  def change
  	drop_table :programs
  	create_table :programs do |t|
  		t.string :title
  		t.integer :dj_id
  		t.datetime :start_time
  		t.text :description
  		t.boolean :is_live_event
  	end
  end
end
