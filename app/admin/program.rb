ActiveAdmin.register Program do


      permit_params :title, :user_id, :deejays, :description, :avatar, :schedules_attributes => [:program_id, :start_time, :duration, days_of_week: []], :episodes_attributes => [:Name, :recorded_at, :id, :_destroy]


  index  do
    column :title
    # column :avatar do |program|
    #   image_tag program.avatar.url(:thumb)
    # end
    column :user_id
    column :description
    actions
  end

  show do |ad|
    attributes_table do
      row :title
      # row :avatar do
      #   image_tag ad.avatar.url(:medium)
      # end
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
                td schedule.days_of_week.to_sentence
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

    # f.inputs "Artwork" do
    #   f.input :avatar, :as => :file, :hint => f.template.image_tag(f.object.avatar.url(:medium))
    # end

    f.inputs "About" do
      f.input :title
      f.input :description
      f.input :user_id, as: :select, :collection => User.order(:djname)
    end

    f.inputs "Schedule" do
      f.has_many :schedules, allow_destroy: true do |schedule_form|
        schedule_form.input :program_id, as: :hidden, :value => program.id
        schedule_form.input :start_time
        schedule_form.input :duration, as: :select, collection: { '30 mins' => 30, '1 hour' => 60, '1.5 hours' => 90, '2 hours' => 120, '2.5 hours' => 180, '3 hours' => 210, '3.5 hours' => 240, '4 hours' => 270, '4.5 hours' => 350, '5 hours' => 380, '5.5 hours' => 410, '6 hours' => 440}
        schedule_form.input :days_of_week, as: :check_boxes, :multiple => true, :collection => ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
      end
    end
    f.actions
  end
end

