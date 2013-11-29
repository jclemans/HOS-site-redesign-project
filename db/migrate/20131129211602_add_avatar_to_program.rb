class AddAvatarToProgram < ActiveRecord::Migration
  def change
    add_attachment :programs, :avatar
  end
end
