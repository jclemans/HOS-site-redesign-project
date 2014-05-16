class ChangeDateColumnName < ActiveRecord::Migration
  def change
    rename_column :episodes, :date, :recorded_at_datetime
  end
end
