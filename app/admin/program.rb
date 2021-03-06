ActiveAdmin.register Program do

  permit_params :title, :user_id, :description, :avatar,
                :schedules_attributes => [:id, :program_id, :start_time, :duration, :_destroy, :day_of_week],
                :episodes_attributes => [:id, :title, :recorded_at, :record_time, :program_id, :_destroy]

  config.batch_actions = false

  index  do
    column :title
    column :avatar do |program|
      image_tag program.avatar.url(:thumb)
    end
    column :user do |program|
      program.user.djname
    end
    column :day_of_week do |program|
      if program.day_of_week
        Date::DAYNAMES[program.day_of_week]
      else
        "?"
      end
    end
    column :description
    actions
  end

  show do |ad|
    attributes_table do
      row :title
      row :avatar do
        image_tag ad.avatar.url(:medium)
      end
      row :description
      row :user_id
      row :schedules do
        h3 "Schedules"
        table do
          tr do
            th "Start Time"
            th "Duration In Minutes"
            th "Days of The Week"
          end
          ad.schedules.each do |schedule|
            tr do
              td schedule.start_time.strftime('%H:%M')
              td schedule.duration
              td schedule.day_of_week
            end
          end
        end
      end

      row :episodes do
        h3 "Episodes"
        table do
          tr do
            th "Title"
            th "Record Time"
            th "Recorded At"
          end
          ad.episodes.each do |episode|
            tr do
              td episode.title
              td episode.record_time
              td episode.recorded_at.to_s(:db)
            end
          end
        end
      end
    end
  end

  form :html => { :enctype => "multipart/form-data" } do |f|

    f.inputs "Artwork" do
      f.input :avatar, :as => :file, :hint => f.template.image_tag(f.object.avatar.url(:medium))
    end

    f.inputs "About" do
      f.input :title
      f.input :description
      f.input :user_id, as: :select, :collection => User.order(:djname)
    end

    f.inputs "Schedule" do
      f.has_many :schedules, allow_destroy: true do |schedule_form|
        schedule_form.input :program_id, as: :hidden, input_html: {:value => program.id}
        schedule_form.input :start_time, as: :time_select, minute_step: 30
        schedule_form.input :duration, as: :select, collection: { '30 mins' => 30, '1 hour' => 60, '1.5 hours' => 90, '2 hours' => 120, '2.5 hours' => 150, '3 hours' => 180, '3.5 hours' => 210, '4 hours' => 240, '4.5 hours' => 270, '5 hours' => 300, '5.5 hours' => 330, '6 hours' => 360}
        schedule_form.input :day_of_week, as: :select, :collection => { 'Sunday' => 0, 'Monday' => 1, 'Tuesday' => 2, 'Wednesday' => 3, 'Thursday' => 4, 'Friday' => 5, 'Saturday' => 6}
      end
    end
    f.inputs "Episodes" do
      f.has_many :episodes do |episode_form|
        episode_form.input :title
      end
    end
    f.actions
  end
end

