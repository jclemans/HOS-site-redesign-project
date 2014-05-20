class AddDurationToPrograms < ActiveRecord::Migration
  def change
  	add_column :programs, :duration, :integer
  end
end
