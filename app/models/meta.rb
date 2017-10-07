class Meta

  ####################################################################
  ####################################################################

    # => Table Exists?
    if ActiveRecord::Base.connection.data_source_exists? :nodes

      if classes = Node.where(ref: "meta")

        # => Each Meta model
        classes.each do |klass| #-> "class" is reserved
          meta = klass.val
          self.const_set meta.titleize, Class.new(Node) do
            accepts_nested_attributes_for   :associations
            has_many meta.pluralize.to_sym, through: :associations, source: :associated, source_type: "Meta::" + meta.titleize, class_name: "Meta::" + meta.titleize
          end
        end

      end

    end

  ####################################################################
  ####################################################################

end
