class DropStartTimeFromPrograms < ActiveRecord::Migration
  def change
    remove_column :programs, :start_time
  end
end
