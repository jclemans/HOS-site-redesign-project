require 'user_program_updater'

class MoveFieldsCreateUsers < ActiveRecord::Migration
  def up
    UserProgramUpdater.run_all
  end
end
