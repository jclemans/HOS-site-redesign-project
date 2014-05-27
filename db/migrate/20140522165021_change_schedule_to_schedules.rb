class ChangeScheduleToSchedules < ActiveRecord::Migration
  def change
    rename_table :schedule, :schedules
  end
end
