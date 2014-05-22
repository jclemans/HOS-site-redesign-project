ActiveAdmin.register Program do

  permit_params :name, :description, :genre, :deejays, :day_of_week, :start_hour, :start_minute, :end_hour, :end_minute, :is_active, :email, :program_url, :episodes_attributes => [:title, :recorded_at, :id, :_destroy]

  index  do
    column :name
    # column :image do |program|
    #   image_tag program.avatar.url(:thumb)
    # end
    column :genre
    column "Day #", :day_of_week
    column :day do |program|
      Date::DAYNAMES[program.day_of_week]
    end
    column :start_hour do |program|
      hour_24_to_12 program.start_hour.to_i
    end
    column :is_active
    actions
  end

  show do |ad|
    attributes_table do
      row :name
      row :email
      row :description
      row :program_url
      row :genre
      row :day_of_week
      row :start_hour
      row :start_minute
      row :end_hour
      row :end_minute

      row :episodes do
        h3 "Episodes"
        table do
          tr do
            th "Title"
            th "Duration"
            th "Recorded At"


          end

          ad.episodes.each do |episode|
            tr do
              td episode.title
              td episode.duration
              td episode.recorded_at.to_s(:db)
            end
          end
        end
      end
    end
  end

  form :html => { :enctype => "multipart/form-data" } do |f|
    f.inputs "Live" do
      f.input :is_active
    end

    # f.inputs "Artwork" do
    #   f.input :avatar, :as => :file, :hint => f.template.image_tag(f.object.avatar.url(:medium))
    # end

    f.inputs "About" do
      f.input :name
      f.input :email
      f.input :description
      f.input :genre
      f.input :deejays
      f.input :program_url
    end

    f.inputs "When" do
      f.input :day_of_week, as: :select, collection: {'Sunday' => 0, 'Monday' => 1, 'Tuesday' => 2, 'Wednesday' => 3, 'Thursday' => 4, 'Friday' => 5, 'Saturday' => 6}
      f.input :start_hour, as: :select, collection: (0..23).collect{|d| d.to_s.rjust(2,"0")}
      f.input :start_minute, as: :select, collection: ["0", "15", "30", "45"]
      f.input :end_hour, as: :select, collection: (0..23).collect{|d| d.to_s.rjust(2,"0")}
      f.input :end_minute, as: :select, collection: ["0", "15", "30", "45"]
    end

    f.inputs "Episodes" do
      f.has_many :episodes,  allow_destroy: true do |episode_form|
        episode_form.input :title
        episode_form.input :duration
        episode_form.input :recorded_at
      end
    end

    f.actions
  end

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

end
