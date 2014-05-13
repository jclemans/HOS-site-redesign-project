class ChangeShowTable < ActiveRecord::Migration
  def change
  	rename_table :shows, :episodes
  end
end
