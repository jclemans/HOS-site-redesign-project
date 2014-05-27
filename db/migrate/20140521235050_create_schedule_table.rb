class CreateScheduleTable < ActiveRecord::Migration
  def change
    create_table :schedule do |t|
      t.integer :program_id
      t.time :start_time
      t.integer :duration
      t.integer :day_of_week, array: true
      t.timestamps
    end
  end
end
