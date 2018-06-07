############################################################
############################################################
##                ___               _                     ##
##               / _ \             | |                    ##
##              / /_\ \___ ___  ___| |_ ___               ##
##              |  _  / __/ __|/ _ \ __/ __|              ##
##              | | | \__ \__ \  __/ |_\__ \              ##
##              \_| |_/___/___/\___|\__|___/              ##
##                                                        ##
############################################################
############################################################

## Assets ##
ActiveAdmin.register Asset do

  ############################################################
  ############################################################

  # => Menu
  menu priority: 12, label: -> { [I18n.t("activerecord.models.asset.icon"),Asset.model_name.human(count: 2)].join(' ') }

  # => Params
  permit_params :user_id, FL::FILE, :notes

  ############################################################
  ############################################################

  # => Index
  index title: [I18n.t("activerecord.models.asset.icon"), 'Assets'].join(' ') do
    selectable_column
    column :id
    column :user
    column :assetable
    image_column FL::FILE, style: :thumb # => ActiveAdmin_Addons
    column :notes
    column :created_at
    column :updated_at
    actions
  end

  filter :email

  form title: [I18n.t("activerecord.models.asset.icon"), 'Assets'].join(' ')  do |f|
    f.inputs "Image Upload" do
      f.input :user, include_blank: false, selected: current_user.id, placeholder: "User"   
      f.input FL::FILE, required: true, as: :file
      f.input :notes
    end
    f.actions
  end
end

############################################################
############################################################
