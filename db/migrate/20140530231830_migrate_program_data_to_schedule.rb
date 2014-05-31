require 'program_schedule_updater'

class MigrateProgramDataToSchedule < ActiveRecord::Migration
  def up
    ProgramScheduleUpdater.run_all
  end
end
