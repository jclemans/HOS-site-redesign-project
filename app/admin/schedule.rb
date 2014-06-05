include HOS::ScheduleHelpers

ActiveAdmin.register Schedule do

  permit_params :program_id, :start_time, :duration, :day_of_week, :episodes_attributes => [:Name, :recorded_at, :id, :_destroy]

  actions :all, :except => [:new]
  config.batch_actions = false

  index do
    column :day_of_week do |schedule|
      to_day(schedule.day_of_week)
    end
    column :start_time
    column :duration
  end
end
