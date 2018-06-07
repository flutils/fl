class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :trackable, :validatable#, :registerable,

####################################################################
####################################################################

  # Virtual Attrs
  attr_accessor :send_email

  # Alias Attributes
  alias_attribute :ref, :email

  ## Profile ##
  has_one :profile, dependent: :destroy, inverse_of: :user
  before_create :build_profile, unless: :profile

  ## Associations ##
  has_many :nodes
  has_many :associations, as: :associatiable, dependent: :destroy

  ## Assets ##
  has_many :assets, as: :assetable, dependent: :destroy

  ## Delegate ##
  delegate :name, :first_name, :slug, :avatar, :role, :public, :admin?, to: :profile
  accepts_nested_attributes_for :profile

  ## Options ##
  after_create Proc.new { |u| ApplicationMailer.new_user(u).deliver! }, if: :send_email

####################################################################
####################################################################

  #####################
  # Instance (private)
  #####################

    # => For form
    def is_destroyable?
      false
    end

  #####################
  # Class (public)
  #####################

####################################################################
####################################################################

end
