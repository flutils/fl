ActiveAdmin.register User do

  ##################################
  ##################################

  # => Menu
  menu priority: 1, label: -> { ['👽', User.model_name.human(count: 2)].join(' ') }

  # => Params
  permit_params :email, :password, :password_confirmation

  ##################################
  ##################################

  # => Index
  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
