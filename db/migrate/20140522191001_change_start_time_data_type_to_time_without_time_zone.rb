class ChangeStartTimeDataTypeToTimeWithoutTimeZone < ActiveRecord::Migration
  def change
    remove_column :schedules, :created_at
    remove_column :schedules, :updated_at
  end
end

