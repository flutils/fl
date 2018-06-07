class Meta

  ####################################################################
  ####################################################################

    # => Table Exists?
    if ActiveRecord::Base.connection.data_source_exists? :nodes

      if classes = Node.where(ref: "meta")

        # => Each Meta model
        classes.each do |klass| #-> "class" is reserved
          self.const_set klass.val.titleize, Class.new(Node)
        end

      end

    end

  ####################################################################
  ####################################################################

end
