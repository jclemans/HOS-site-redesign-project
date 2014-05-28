ActiveAdmin.register Schedule do

  permit_params :program_id, :start_time, :duration, :day_of_week, :episodes_attributes => [:Name, :recorded_at, :id, :_destroy]

  actions :all, :except => [:new]
  config.batch_actions = false

  index  do
    column :start_time
    column :duration
    column :day_of_week
  end

  show do |ad|
    attributes_table do
      row :start_time
      row :duration
      row :day_of_week
    end
  end
end
