# => Check if ActiveAdmin loaded
if Gem.loaded_specs.has_key?('activeadmin')
  #puts defined?(ActiveAdmin)

  # => Engine
  # => https://github.com/activeadmin/activeadmin/wiki/define-a-resource-inside-an-engine
  ActiveAdmin.application.load_paths += [File.join(__dir__, '..', '..', 'app', 'admin')]

  # => Use this hook to configure ActiveAdmin
  ActiveAdmin.setup do |config|

    # == Site Title
    #
    # Set the title that is displayed on the main layout
    # for each of the active admin pages.
    #
    config.site_title = Rails.application.secrets.app[:title]

    # Set the link url for the title. For example, to take
    # users to your main site. Defaults to no link.
    #
    # config.site_title_link = "/"
    #config.site_title_link = "/"

    # Set an optional image to be displayed for the header
    # instead of a string (overrides :site_title)
    #
    # Note: Recommended image height is 21px to properly fit in the header
    #
    # config.site_title_image = "/images/logo.png"

    # == Default Namespace
    #
    # Set the default namespace each administration resource
    # will be added to.
    #
    # eg:
    #   config.default_namespace = :hello_world
    #
    # This will create resources in the HelloWorld module and
    # will namespace routes to /hello_world/*
    #
    # To set no namespace by default, use:
    #   config.default_namespace = false
    #
    # Default:
    config.default_namespace = false
    #
    # You can customize the settings for each namespace by using
    # a namespace block. For example, to change the site title
    # within a namespace:
    #
    #   config.namespace :admin do |admin|
    #     admin.site_title = "Custom Admin Title"
    #   end
    #
    # This will ONLY change the title for the admin section. Other
    # namespaces will continue to use the main "site_title" configuration.

    # == User Authentication
    #
    # Active Admin will automatically call an authentication
    # method in a before filter of all controller actions to
    # ensure that there is a currently logged in admin user.
    #
    # This setting changes the method which Active Admin calls
    # within the controller.
    config.authentication_method = :authenticate_user!


    # == Current User
    #
    # Active Admin will associate actions with the current
    # user performing them.
    #
    # This setting changes the method which Active Admin calls
    # to return the currently logged in user.
    config.current_user_method = :current_user


    # == Logging Out
    #
    # Active Admin displays a logout link on each screen. These
    # settings configure the location and method used for the link.
    #
    # This setting changes the path where the link points to. If it's
    # a string, the strings is used as the path. If it's a Symbol, we
    # will call the method to return the path.
    #
    # Default:
    config.logout_link_path = :destroy_user_session_path

    # This setting changes the http method used when rendering the
    # link. For example :get, :delete, :put, etc..
    #
    # Default:
    # config.logout_link_method = :get

    # == Root
    #
    # Set the action to call for the root path. You can set different
    # roots for each namespace.
    #
    # Default:
    config.root_to = 'options#index'

    # == Admin Comments
    #
    # Admin comments allow you to add comments to any model for admin use.
    # Admin comments are enabled by default.
    #
    # Default:
    config.comments = false
    #
    # You can turn them on and off for any given namespace by using a
    # namespace config block.
    #
    # Eg:
    #   config.namespace :without_comments do |without_comments|
    #     without_comments.allow_comments = false
    #   end

    # == Localize Date/Time Format
    #
    # Set the localize format to display dates and times.
    # To understand how to localize your app with I18n, read more at
    # https://github.com/svenfuchs/i18n/blob/master/lib%2Fi18n%2Fbackend%2Fbase.rb#L52
    #
    config.localize_format = :short

    # == Setting a Favicon
    config.favicon = 'favicon.ico'

    # == Meta Tags
    #
    # Add additional meta tags to the head element of active admin pages.
    #
    # Add tags to all pages logged in users see:
    config.meta_tags = {
      author:      Rails.application.secrets.app[:author],
      keywords:    Rails.application.secrets.app[:keywords],
      description: Rails.application.secrets.app[:description]
    }

    # By default, sign up/sign in/recover password pages are excluded
    # from showing up in search engine results by adding a robots meta
    # tag. You can reset the hash of meta tags included in logged out
    # pages:
    #   config.meta_tags_for_logged_out_pages = {}

    # == Removing Breadcrumbs
    #
    # Breadcrumbs are enabled by default. You can customize them for individual
    # resources or you can disable them globally from here.
    #
    # config.breadcrumb = false

    # == Create Another Checkbox
    #
    # Create another checkbox is disabled by default. You can customize it for individual
    # resources or you can enable them globally from here.
    #
    # config.create_another = true

    # == Register Stylesheets & Javascripts
    #
    # We recommend using the built in Active Admin layout and loading
    # up your own stylesheets / javascripts to customize the look
    # and feel.
    #
    # To load a stylesheet:
    #   config.register_stylesheet 'my_stylesheet.css'
    #
    # You can provide an options hash for more control, which is passed along to stylesheet_link_tag():
    #   config.register_stylesheet 'my_print_stylesheet.css', media: :print
    #
    # To load a javascript file:
    # This is deprecated
    #   config.register_javascript 'my_javascript.js'

    # == CSV options
    #
    # Set the CSV builder separator
    # config.csv_options = { col_sep: ';' }
    #
    # Force the use of quotes
    # config.csv_options = { force_quotes: true }

    # == Batch Actions
    #
    # Enable and disable Batch Actions
    #
    config.batch_actions = true

    # == Menu System
    #
    # You can add a navigation menu to be used in your application, or configure a provided menu
    #
    # To change the default utility navigation to show a link to your website & a logout btn
    #
    #   config.namespace :admin do |admin|
    #     admin.build_menu :utility_navigation do |menu|
    #       menu.add label: "My Great Website", url: "http://www.mygreatwebsite.com", html_options: { target: :blank }
    #       admin.add_logout_button_to_menu menu
    #     end
    #   end

    ### Custom User Credentials (top right) ###
    #config.namespace "" do |admin|
    #  admin.build_menu :utility_navigation do |menu|
    ##    menu.add  :label  => proc{ display_name current_active_admin_user.name },
    #      :url    =>  proc{  edit_admin_admin_user_path(current_active_admin_user) }  ,#link_to current_active_admin_user,
    #      :id     => 'current_user',
    #      :if     => proc{ current_active_admin_user? }
    #    admin.add_logout_button_to_menu menu
    #  end
    #end

    #
    # If you wanted to add a static menu item to the default menu provided:
    #
    #   config.namespace :admin do |admin|
    #     admin.build_menu :default do |menu|
    #       menu.add label: "My Great Website", url: "http://www.mygreatwebsite.com", html_options: { target: :blank }
    #     end
    #   end

    # == Download Links
    #
    # You can disable download links on resource listing pages,
    # or customize the formats shown per namespace/globally
    #
    # To disable/customize for the :admin namespace:
    #
    #   config.namespace :admin do |admin|
    #
    #     # Disable the links entirely
    #     admin.download_links = false
    #
    #     # Only show XML & PDF options
    #     admin.download_links = [:xml, :pdf]
    #
    #     # Enable/disable the links based on block
    #     #   (for example, with cancan)
    #     admin.download_links = proc { can?(:view_download_links) }
    #
    #   end

    # == Pagination
    #
    # Pagination is enabled by default for all resources.
    # You can control the default per page count for all resources here.
    #
    # config.default_per_page = 30
    #
    # You can control the max per page count too.
    #
    # config.max_per_page = 10_000

    # == Filters
    #
    # By default the index screen includes a "Filters" sidebar on the right
    # hand side with a filter for each attribute of the registered model.
    # You can enable or disable them for all resources here.
    #
    # config.filters = true
    #
    # By default the filters include associations in a select, which means
    # that every record will be loaded for each association.
    # You can enabled or disable the inclusion
    # of those filters by default here.
    #
    # config.include_default_association_filters = true

    # == Footer
    #
    # By default, the footer shows the current Active Admin version. You can
    # override the content of the footer here.
    #
    config.footer = "<b><a href=\"#{Rails.application.secrets[:app][:domain]}\">#{Rails.application.secrets[:app][:name]}</a> © #{Date.today.year}</b>".html_safe

  end

end
