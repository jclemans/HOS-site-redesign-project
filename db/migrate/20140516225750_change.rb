class Change < ActiveRecord::Migration
  def change
    rename_column :episodes, :recorded_at_datetime, :recorded_at
  end
end
