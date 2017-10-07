class Profile < ApplicationRecord

####################################################################

  # User
  belongs_to :user, inverse_of: :profile

  # Role
  belongs_to :role, class_name: "Meta::Role", primary_key: :ref, foreign_key: :role, optional: true

  # Avatar
  has_one :avatar, class_name: "Asset", as: :assetable, dependent: :destroy
  accepts_nested_attributes_for :avatar, reject_if: :all_blank

  # Validation
  validates :name, length: { minimum: 2 }, allow_blank: true # => http://stackoverflow.com/a/22323406/1143732

  # Nilify Blanks
  # Used for "name" validation -- submit nil if doesn't show
  nilify_blanks only: [:name]

  # Names
  alias_attribute :ref, :name

  # Slug
  extend FriendlyId
  friendly_id :name

####################################################################

  # Instance (private)
  ###################

  # => Name
  def name
    self[:name] || user.email
  end

  # => First Name
  def first_name
    name.split.first
  end

  # Class (public)
  ###################

####################################################################

end
