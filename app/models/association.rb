class Association < ApplicationRecord

####################################################################

  # Central "Association" Model -- Stores every association between nodes
  ##########################################

    belongs_to :associatiable, 	polymorphic: :true
    belongs_to :associated, 	  polymorphic: true

    # Nested attributes
    #classes = Meta::Property.all
    #if classes.any?
  #    classes.each do |klass| # => Class reserved
  #      accepts_nested_attributes_for klass.ref.to_sym, allow_destroy: true
  #    end
  #  end

####################################################################

end
