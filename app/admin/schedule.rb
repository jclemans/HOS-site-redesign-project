ActiveAdmin.register Schedule do

  permit_params :program_id, :start_time, :duration, days_of_week: [], :episodes_attributes => [:Name, :recorded_at, :id, :_destroy]

end
