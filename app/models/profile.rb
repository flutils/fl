class Profile < ApplicationRecord

  ###########################################################
  ###########################################################
  ##              _____           __ _ _                   ##
  ##             | ___ \         / _(_) |                  ##
  ##             | |_/ / __ ___ | |_ _| | ___              ##
  ##             |  __/ '__/ _ \|  _| | |/ _ \             ##
  ##             | |  | | | (_) | | | | |  __/             ##
  ##             \_|  |_|  \___/|_| |_|_|\___|             ##
  ##                                                       ##
  ###########################################################
  ###########################################################
  ##        Adds extra stuff for user profiles etc         ##
  ###########################################################
  ###########################################################

    # User
    belongs_to :user, inverse_of: :profile

    # Avatar
    has_one :avatar, class_name: "Asset", as: :assetable, dependent: :destroy
    accepts_nested_attributes_for :avatar, reject_if: :all_blank

    # Validation
    validates :name, length: { minimum: 2 }, allow_blank: true # => http://stackoverflow.com/a/22323406/1143732

    # Nilify Blanks
    nilify_blanks only: [:name]

    # Names
    alias_attribute :ref, :name

    # Roles
    enum role: [:user, :admin]

    # Slug
    extend FriendlyId
    friendly_id :name

  ###########################################################
  ###########################################################

    # Instance (private)
    ###################

    # => First Name
    def first_name
      name.try(:split).try(:first)
    end

    # Class (public)
    ###################

  ###########################################################
  ###########################################################

end
