############################################################
############################################################
##               _   _                                    ##
##              | | | |                                   ##
##              | | | |___  ___ _ __ ___                  ##
##              | | | / __|/ _ \ '__/ __|                 ##
##              | |_| \__ \  __/ |  \__ \                 ##
##               \___/|___/\___|_|  |___/                 ##
##                                                        ##
############################################################
############################################################

## Users ##
ActiveAdmin.register User do

  ##################################
  ##################################

  # => Menu
  menu priority: 1, label: -> { [I18n.t("activerecord.models.user.icon")|| nil, User.model_name.human(count: 2)].join(' ') }

  # => Params
  permit_params :email, :password, :password_confirmation, profile_attributes: [:id, :name, :role, :public, avatar_attributes: [:id, FL::FILE, :_destroy]]

  ##################################
  ##################################

  # => Index
  index title: [I18n.t("activerecord.models.user.icon"), 'Users'].join(' ') do
    selectable_column
    column 'Avatar' do |user|
      if user.try(:avatar).try(:url)
        image_tag user.try(:avatar).try(:url, :thumb)
      else
        'N/A'
      end
    end
    #image_column        :avatar, style: :thumb
    column              :name
    column              :email
    tag_column          :role
    column 'Public' do |user|
      user.profile.public
    end
    column              :sign_in_count
    column              :current_sign_in_at
    column              :last_sign_in_at
    actions
  end

  filter :email

  form title: [I18n.t("activerecord.models.user.icon"), 'Users'].join(' ') do |f|
    f.inputs "Profile", for: [:profile, f.object.profile || f.object.build_profile] do |p|

      p.has_many :avatar, new_record: true, allow_destroy: true, heading: false do |a|
        a.input FL::FILE, required: true, as: :file, hint: p.object.avatar.nil? ? p.template.content_tag(:span, "No Image Yet") : p.template.image_tag(p.object.avatar.url(:thumb))
      end

      p.input :name, placeholder: 'Name'
      p.input :role
      p.input :public
    end

    f.inputs "Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end

############################################################
############################################################
