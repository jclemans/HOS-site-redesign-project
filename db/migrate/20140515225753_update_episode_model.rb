class UpdateEpisodeModel < ActiveRecord::Migration
  def change
  	add_column :episodes, :duration, :integer
  	add_column :episodes, :title, :string
  	rename_column :episodes, :when, :date
  	remove_column :episodes, :is_finished
  end
end
