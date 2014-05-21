class RecordTimeToDuration < ActiveRecord::Migration
  def change
  	rename_column :episodes, :duration, :record_time  
  end
end
