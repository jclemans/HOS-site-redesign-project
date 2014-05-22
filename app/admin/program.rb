ActiveAdmin.register Program do

  permit_params :title, :user_id, :is_live_event, :description, :avatar, :schedules_attributes => [:program_id,:start_time, :duration, :day_of_week ], :episodes_attributes => [:title, :recorded_at, :id, :_destroy]

  index  do
    column :title
    column :avatar do |program|
      image_tag program.avatar.url(:thumb)
    end
    column :user_id
    column :description
    column :is_live_event
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
      row :is_live_event
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
      f.input :user_id, as: :select, :collection => User.order("djname ASC").all
    end

    f.inputs "Schedule" do
      f.has_many :schedules, allow_destroy: true do |schedule_form|
        schedule_form.input :program_id, as: :hidden, :value => program.id
        schedule_form.input :start_time
        schedule_form.input :duration, as: :select, collection: { '30 mins' => 30, '1 hour' => 60, '1.5 hours' => 90, '2 hours' => 120, '2.5 hours' => 180, '3 hours' => 210, '3.5 hours' => 240, '4 hours' => 270, '4.5 hours' => 350, '5 hours' => 380, '5.5 hours' => 410, '6 hours' => 440}
        schedule_form.input :day_of_week, as: :check_boxes, collection: {'Sunday' => 0, 'Monday' => 1, 'Tuesday' => 2, 'Wednesday' => 3, 'Thursday' => 4, 'Friday' => 5, 'Saturday' => 6}
      end
    end
    f.actions
  end
end

