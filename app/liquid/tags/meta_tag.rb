###################################################
###################################################
##            ___  ___     _                     ##
##            |  \/  |    | |                    ##
##            | .  . | ___| |_ __ _              ##
##            | |\/| |/ _ \ __/ _` |             ##
##            | |  | |  __/ || (_| |             ##
##            \_|  |_/\___|\__\__,_|             ##
###################################################
###################################################

class Tags::MetaTag < Liquid::Tag
  Syntax = /(#{::Liquid::QuotedFragment}+)?/

  ########################################
  ########################################

    ## Parse Arguments ##
    ## Define args here and pass to renderer as @variables ##
    def initialize tag_name, markup, tokens
      @tag    = tag_name
      @markup = markup.split(", ")
      super
    end

    ## Output
    def render context
      meta @tag, @markup
    end

  ########################################
  ########################################

  private

    # Helpers
    def helpers
      @helpers ||= ApplicationController.helpers
    end

    # Meta
    # => Main meta method
    # => tag is for self-enclosed tags (<meta> etc)
    def meta type, *args
      options = args.join(', ')

      # Return Values
      case type.to_sym
        when :js, :javascript, :javascripts, :script, :scripts
          helpers.javascript_include_tag *args
        when :css, :stylesheet, :stylesheets
          helpers.stylesheet_link_tag	*args
        when :title
          helpers.content_tag :title, options
        when :favicon
          helpers.favicon_link_tag "icons/favicon.ico"
        when :csrf
          #helpers.csrf_meta_tags
        else
  				helpers.tag :meta, name: type, content: options
      end
    end

  ########################################
  ########################################

    # Robots
    # => http://noarchive.net/meta/
    def robots *args

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
        meta :favicon, "https://www.frontlineutilities.co.uk/favicon.ico"
      end
    end

  ########################################
  ########################################

end

###################################################
###################################################
