module FL
  module LiquidHelper

  	##########################
  	## Liquid ##
  	##########################

      # => Liquidize
      def liquidize content, *args
        template = Liquid::Template.parse content
        sanitize template.render
      end

    ##########################
  	##########################

    private

      # => Shortcodes
      def shortcodes
        cache = ActiveSupport::Cache::MemoryStore.new
        cache.read :shortcodes
      end

  	##########################
  	##########################

  end
end
