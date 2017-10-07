module FL
  module AssetHelper

  	##########################
  	##########################

      # => Sass
      def sass hash
        self.sass hash
      end

    ##########################
  	##########################

      # => Sass
      # => Takes HASH or YML and turns into SASS vars
      # => Used in config/initializers/sass.rb & assets/stylesheets/application.sass.erb
      def self.sass hash, default=false
        vars = {}

        # Cycle through data
        # Recursion handled by "each_nested_pair"
        # Here you determine the best parts

        # Determine if hash is hash or path
        # If path change into hash by loading YML
        hash = YAML.load_file(hash) if hash.is_a?(String) || hash.is_a?(Pathname) # => Needs some sort of rescue

        # General
        # http://api.rubyonrails.org/classes/Hash.html#method-i-except
        hash.except("development", "production", "staging").each_nested_pair do |k,v|
          vars[k] = v if v
        end

        # Env
        if hash[Rails.env] # => Ensure that there is a key for the env
          hash[Rails.env].each_nested_pair do |k,v|
            vars[k] = v if v
          end
        end

        # Return
        vars.map{|k,v| "$#{k}: #{v} #{"!default" if default}"}.join("\n")
      end

    ##########################
  	##########################

  end
end
