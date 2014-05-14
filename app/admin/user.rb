ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation,
    role_ids:[]

  index do
    column :id
    column :email
    column 'Roles' do |user|
      user.roles.collect { |role| role.name }.to_sentence
    end
    default_actions
  end

  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :roles,  :label => "Roles", :as => :check_boxes, :collection => Role.all
      f.actions
    end
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
