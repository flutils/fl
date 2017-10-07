class Node < ApplicationRecord 

  ####################################################################

    # Central Repository
    ##########################################

      # Virtual attrs
      attr_accessor :seed # => https://richonrails.com/articles/skipping-validations-in-ruby-on-rails

      # Associations
      # http://blog.bigbinary.com/2016/02/15/rails-5-makes-belong-to-association-required-by-default.html
      belongs_to :user, optional: true

      # Validations
      validates :ref, :val, length: { minimum: 2,         message: "2 characters minimum" },          unless: :seed
      validates :ref, exclusion:    { in: %w(meta role),  message: "%{value} is reserved" },          unless: :seed  # => http://stackoverflow.com/a/17668634/1143732
      validates :ref, uniqueness:   {                     message: "%{value} cannot be duplicate" },  unless: :seed
      validates :val, uniqueness:   { scope: :ref,        message: "%{value} cannot be duplicate" }

      # Friendly ID
      extend FriendlyId
      friendly_id :title

    ##########################################

      # Aliases
      alias_attribute :title,       :ref
      alias_attribute :value,       :val
      alias_attribute :content,     :val
      alias_attribute :description, :val

    ##########################################

      # Instance (private)
      ###################

      # => Partial Path
      # => https://www.cookieshq.co.uk/posts/rails-tips-to-partial-path/
      def to_partial_path
        self.class.name.underscore # => http://blog.obiefernandez.com/content/2012/01/rendering-collections-of-heterogeneous-objects-in-rails-32.html
      end

      # => For form
      def is_destroyable?
        true
      end

      # Class (public)
      ###################

      # => Ref / Val
      # => Meta::Role.val "admin"
      scope :ref, ->(ref) { find_by ref: ref }
      scope :val, ->(val) { find_by val: val }

  ####################################################################

end
