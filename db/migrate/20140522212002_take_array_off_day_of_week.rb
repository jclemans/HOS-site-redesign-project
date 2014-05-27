class TakeArrayOffDayOfWeek < ActiveRecord::Migration
  def change
    remove_column :schedules, :day_of_week
    add_column :schedules, :days_of_week, :integer
  end
end
