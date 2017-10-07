class Tags::IconTag < Liquid::Tag
  Syntax = /(#{::Liquid::QuotedFragment}+)?/

  #################################

    ## Init ##
    def initialize tag_name, markup, tokens
      if markup =~ Syntax
        @icon = $1.gsub('\'', '')
      else
        raise ::Liquid::SyntaxError.new("Syntax Error in 'Icon Tag' - Valid syntax: {% i <args> %}")
      end

      super
    end

  #################################

    ## Helpers ##
    def helpers
      @helpers ||= ApplicationController.helpers
    end

  #################################

    ## Output ##
    def render context
      gem_name = 'font-awesome-rails'
      gdep = Gem::Dependency.new gem_name

      # Invoke
      helpers.send (gdep.matching_specs.max_by(&:version) ? :fa_icon : :ion_icon), @icon
    end

  #################################

end
