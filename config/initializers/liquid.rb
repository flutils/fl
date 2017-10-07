# => Loaded?
if Gem.loaded_specs.has_key? "liquid"


  ###################################################
  ###################################################

  ## http://code.runnable.com/Up0qFjHu834vAABr/how-to-use-for-loops-in-liquid-templates-for-ruby-on-rails ##
  class LiquidTemplateHandler
    def self.call(template)
       "sanitize LiquidTemplateHandler.new(self).render(#{template.source.inspect}, local_assigns)"
    end

    ###################################################
    ###################################################

    def initialize(view)
      @view = view
    end

    def render(template, local_assigns = {})
      @view.controller.headers["Content-Type"] ||= 'text/html; charset=utf-8'

      assigns = @view.assigns

      if @view.content_for?(:layout)
        assigns["content_for_layout"] = @view.content_for(:layout)
      end
      assigns.merge!(local_assigns.stringify_keys)

      controller = @view.controller
      filters = if controller.respond_to?(:liquid_filters, true)
                  controller.send(:liquid_filters)
                elsif controller.respond_to?(:master_helper_module)
                  [controller.master_helper_module]
                else
                  [controller._helpers]
                end


      liquid = Liquid::Template.parse(template)
      liquid.render(assigns, :filters => filters, :registers => {:action_view => @view, :controller => @view.controller})
    end

    def compilable?
      false
    end
  end

  #ActionView::Template.register_template_handler :liquid, LiquidTemplateHandler


  ###############################
  ###############################

    # => Shortcodes
    # => Should be extracted into own class / module
    cache = ActiveSupport::Cache::MemoryStore.new
    cache.write "shortcodes", { "CSS" => "TEST" }

  ###############################
  ###############################

  ## Filters ##
  ## these are meant to provide simple "transations"  for code ##
  ## Treat as shortcuts ##
  ## {{ expression | call | call | call }}
  #Liquid::Template.register_filter 'meta', MetaFilter

  ## Tags ##
  ## These are meant to be programmatic - if loops etc ##
  ## Treat as small widget / app ##
  ## {% title new title %}
  ## {% icon database %}
  %w(meta title csrf robots favicon js viewport stylesheet).each do |meta|
    Liquid::Template.register_tag meta, Tags::MetaTag
  end

  Liquid::Template.register_tag 'icon',           Tags::IconTag
  Liquid::Template.register_tag 'ga',             Tags::GoogleAnalyticsTag

  ## Drops ##
  ## Provide access to backend data (User / Node / etc) ##
  ## Treat as object -- user.name etc ##
  ## {{ user.name }} {{ options.analytics }}

end
