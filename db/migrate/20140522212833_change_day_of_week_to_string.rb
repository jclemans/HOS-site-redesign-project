class ChangeDayOfWeekToString < ActiveRecord::Migration
  def change
    remove_column :schedules, :days_of_week
    add_column :schedules, :days_of_week, :string
  end
end
