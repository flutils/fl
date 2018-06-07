module FL
  module ApplicationHelper

  	##########################
  	##########################

  		# => Current Layout
  		# => Need to pass some sort of object to it, otherwise fails
  		# => http://stackoverflow.com/questions/22787021/rails-4-name-of-current-layout
  		def current_layout
  			layout = controller.send :_layout, ["test"]
  			layout.inspect.split("/").last.gsub(/.haml/,"").tr('"', '')
  		end

  		# => Admin?
  	  # => Checks for namespace
  	  # => http://stackoverflow.com/a/15028731/1143732 (comment)
  	  # => Devise should be "devise_controller?"
  	  def admin?
  	    defined? Admin  and controller.class.parents.include? Admin
        defined? Devise and controller.class.parents.include? Devise
  	  end

      # => Icons
      def i *args
        gem_name = 'font-awesome-rails'
        gdep = Gem::Dependency.new(gem_name)
        gdep.matching_specs.max_by(&:version) ? fa_icon(*args) : ion_icon(*args)
      end

  	##########################
    ##########################

      ## Devise ##
    	def resource_name
    		:user
    	end

    	## Class ##
    	def resource
    		@resource ||= User.new
    	end

    		## Mappings ##
    	def devise_mapping
    		@devise_mapping ||= Devise.mappings[:user]
    	end

  	##########################
  	##########################

      # => Credentials
      # => Pulls credentials from db or fallback
      def self.credentials main, sub
        Meta::Option.find_by(ref: "#{main}_#{sub}").try(:val) || Rails.application.credentials[Rails.env.to_sym][main.to_sym][sub.to_sym] || nil
      end

    ##########################
  	##########################

  end
end
