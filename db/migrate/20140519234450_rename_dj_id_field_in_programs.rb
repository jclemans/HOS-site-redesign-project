class RenameDjIdFieldInPrograms < ActiveRecord::Migration
  def change
  	rename_column :programs, :dj_id, :user_id
  end
end
