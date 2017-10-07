module FL
  module MetaHelper

  ########################################
  ########################################

  	############
  	#   Meta   #
  	############

  	# => Meta
  	# => SPLAT OPERATOR for multiple "when" cases -- http://stackoverflow.com/a/10197397/1143732
  	def meta type, *args
  		case type
  			when :js, :javascript, :javascripts, :script, :scripts
  				javascript_include_tag	*args.compact #-> splat operator http://stackoverflow.com/questions/13795627/ruby-send-method-passing-multiple-parameters
  			when :css, :stylesheet, :stylesheets
  				stylesheet_link_tag	*args.compact #-> splat operator http://stackoverflow.com/questions/13795627/ruby-send-method-passing-multiple-parameters
  			when :title
  				Haml::Engine.new("%title #{args.join(' ')}").render
  			when :favicon
  				favicon_link_tag
        when :csrf
          csrf_meta_tags
  			else
  				Haml::Engine.new("%meta{ name: \"#{type}\", content: \"#{args.join(', ')}\" }").render #-> http://stackoverflow.com/questions/9143761/meta-descritpion-in-haml-with-outside-variable
  		end
  	end

  ########################################
  ########################################

  	# => Title (needs to be more succinct)
  	def title args
  		meta :title, args
  	end

    # => CSS
    def css *args
      meta :css, *args
    end

    # => JS
    def js *args
      meta :js, *args
    end

    # => CSRF
    def csrf
      meta :csrf
    end

  ########################################
  ########################################

  	# Robots
  	# => http://noarchive.net/meta/
  	def robots *args
  		# => Blank for all true

  		# => Possible inputs:
  		# => { index: true, follow: true, nofollow: false, noindex: false }
  		# => :index, :follow, :noindex, :nofollow
  		# => "index", "follow", "noindex", "nofollow"

  		# => Inputs
  		# => No input = all
  		# => If true and false are present, only true is passed
  		options  = args.extract_options! # => Don't need defaults

  		# => Results
  		results = Array.new(2)
  		# No options / args =  "index, follow"
  		# First check for one of the following :index, index: true, noindex: false 			== "index"
  		# Second check for one of the following :follow, follow: true, nofollow: false 	== "follow"
  		# Third check for one of the following :noindex, noindex: true 									== "noindex"
  		# Forth check for one of the following :nofollow, nofollow: true								== "nofollow"
  		results[0] = "index" 		if options[:index] || args.include?(:index) || options[:noindex] == false || (options.empty? && args.empty?)
  		results[1] = "follow" 	if options[:follow] || args.include?(:follow) || options[:nofollow] == false || (options.empty? && args.empty?)
  		results[0] = "noindex" 	if (options[:noindex] || args.include?(:noindex) || options[:index] == false) && (!args.include?(:index))
  		results[1] = "nofollow" if (options[:nofollow] || args.include?(:nofollow) || options[:follow] == false) && (!args.include?(:follow))

  		results.delete_at(0) if (options[:index] == false) && (options[:index] != true || !args.include?(:index))
  		results.delete_at(1) if (options[:follow] == false) && (options[:follow] != true || !args.include?(:follow))

  		# => Return
  		# => Options only accepts actual content (array)
   		meta :robots, results.compact.join(",") if results.any?
  	end

  	# Favicon
  	# => https://github.com/audreyr/favicon-cheat-sheet
  	# => http://iconhandbook.co.uk/reference/chart/favicons/
  	def favicon img="icons/favicon.ico", *args

  		# => Accepts all styles of icon
  		defaults = { "apple-touch-icon" => [57,60,72,76,114,120,144,152,167,180], "icon" => [16,32] }
  		options  = args.extract_options!.merge!(defaults) { |key, v1, v2| v1 }

  		case options
  			when :all

  			when true
  		else
  			meta :favicon, img
  		end
  	end

  ########################################
  ########################################

  end
end
