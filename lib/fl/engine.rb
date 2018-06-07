##############################################################
##############################################################
##                        _____ _                           ##
##                       |  ___| |                          ##
##                       | |_  | |                          ##
##                       |  _| | |                          ##
##                       | |   | |____                      ##
##                       \_|   \_____/                      ##
##                                                          ##
##############################################################
##############################################################

# => FL
module FL

  ####################################
  ####################################

  # => Engine
  class Engine < Rails::Engine

    # => Migrations
    # => This has to be kept in an initializer (to access app)
    # => https://blog.pivotal.io/labs/labs/leave-your-migrations-in-your-rails-engines
    initializer :migrations do |app|
      config.paths["db/migrate"].expanded.each do |expanded_path|
        app.config.paths["db/migrate"] << expanded_path
      end
    end

    # => Belongs To
    # => https://blog.bigbinary.com/2016/02/15/rails-5-makes-belong-to-association-required-by-default.html
    initializer :belongs_to do |app|
      app.config.active_record.belongs_to_required_by_default = true
    end

    # => SASS Vars
    # => http://stackoverflow.com/a/4081810/1143732
    config.before_initialize do |app|
      Rails::Generators.invoke("fl:sass_vars") if !File.exist?("#{app.root}/config/sass.yml") && File.basename($0) != 'rake'
    end

    # => ExceptionHandler
    config.exception_handler = { db: nil }

    # => Assets
    config.assets.precompile << %w(application.css application.js)

    # => Equivalent of application.rb
    # => Needs before_initialize otherwise is overwritten
    # => A file at lib/blorgh/engine.rb, which is identical in function to a standard Rails application's config/application.rb file
    # => http://guides.rubyonrails.org/engines.html#generating-an-engine
    config.before_initialize do |app|

      # => TimeZone
      app.config.time_zone = Rails.application.credentials[Rails.env.to_sym][:app][:time_zone] || "GMT"

      ###########################################
      ###########################################

        # => Email
        # => https://sendgrid.com/docs/Integrate/Frameworks/rubyonrails.html
        # => http://apidock.com/rails/ActionMailer/Base/default/class
        app.config.action_mailer.logger             = Rails.application.credentials[Rails.env.to_sym][:mail][:logger] || nil
        app.config.action_mailer.delivery_method    = :smtp
        app.config.action_mailer.default_options    = { host: Rails.application.credentials[Rails.env.to_sym][:app][:domain], from: "#{Rails.application.credentials[Rails.env.to_sym][:app][:name]} <#{Rails.application.credentials[Rails.env.to_sym][:app][:email]}>" }
        app.config.action_mailer.smtp_settings      = {
          user_name:            Rails.application.credentials[Rails.env.to_sym][:mail][:user],
          password:             Rails.application.credentials[Rails.env.to_sym][:mail][:pass],
          address:              Rails.application.credentials[Rails.env.to_sym][:mail][:host],
          port:                 Rails.application.credentials[Rails.env.to_sym][:mail][:port],
          authentication:       Rails.application.credentials[Rails.env.to_sym][:mail][:auth]    || :plain,
          enable_starttls_auto: Rails.application.credentials[Rails.env.to_sym][:mail][:ttls]    || true,
          openssl_verify_mode:  Rails.application.credentials[Rails.env.to_sym][:mail][:openssl] || nil,
          domain:               Rails.application.credentials[Rails.env.to_sym][:app][:domain]
        }

      ###########################################
      ###########################################

        # => Sanitized
        # => http://api.rubyonrails.org/classes/ActionView/Helpers/SanitizeHelper.html
        config.action_view.sanitized_allowed_tags       = %w(div span p b strong i u section img h1 h2 h3 h4 br font table form input iframe audio hr ol ul li em script button a title style link meta large blockquote tbody tr td)
        config.action_view.sanitized_allowed_attributes = %w(id class rel type style name title src alt value accept-charset data method action type data-allow-remember-me data-original-title data-amount data-currency data-description data-image data-product data-key data-label data-locale data-name href bgcolor content data-city data-coords rowspan valign)

        # => Paperclip Interpolation
        # => This is required because referencing config.assets.prefix directly does not inherit environment
        Paperclip.interpolates :asset_path do |attachment, style|
          Rails.application.config.assets.prefix
        end

        # => Paperclip Defaults
        # => http://stackoverflow.com/a/7949067/1143732
        app.config.paperclip_defaults = {
          preserve_files: false,
          default_style:  :medium,
          keep_old_files: true,
          styles: { large: "x850", medium: "x450", thumb: "x200"},
          url:  Rails.application.credentials[Rails.env.to_sym][:app].try(:paperclip).try(:url)  || '/assets/:attachment/:id/:style/:basename.:extension',
          path: Rails.application.credentials[Rails.env.to_sym][:app].try(:paperclip).try(:path) || ':rails_root/public:url'
        }

        # => Pusher
        if Gem.loaded_specs.has_key? "pusher"
          %i(app_id key secret cluster encrypted logger).each do |item|
            Pusher.send item.to_s + "=", Rails.application.credentials[Rails.env.to_sym][:pusher][item]
          end
        end

        # => FriendlyID
        FriendlyId::Slug.table_name = :slugs

        # => Devise - https://github.com/plataformatec/devise/issues/2209#issuecomment-12381713
        app.config.to_prepare do
          DeviseController.respond_to :html, :json
        end

      ###########################################
      ###########################################

        # => Base URL
        # => https://github.com/rails-api/active_model_serializers/blob/master/docs/general/getting_started.md#rails-integration
        Rails.application.routes.default_url_options = { host: Rails.application.credentials[Rails.env.to_sym][:app][:domain] }

        # => Partials using Namespacing
        # => As referenced in this pull request: https://github.com/rails/rails/pull/5625
        # => https://github.com/rails/rails/blob/master/actionview/lib/action_view/base.rb#L151
        app.config.action_view.prefix_partial_path_with_controller_namespace = false

        # => Responders
        # => https://github.com/plataformatec/responders#flashresponder
        app.config.responders.flash_keys = [ :success, :failure ]

        # => Markdown (for CKEditor skins)
        # => https://github.com/rails/sprockets/blob/99444c0a280cc93e33ddf7acfe961522dec3dcf5/guides/extending_sprockets.md#register-mime-types
        config.before_initialize do |app|
          Sprockets.register_mime_type 'text/markdown', extensions: ['.md']
        end

      ###########################################
      ###########################################

        # => Asset Prefix
        # => Devise doesn't work with just base path
        # => Added leading slash for CKEditor (check for update to remove leading slash)
        # => https://github.com/galetahub/ckeditor/compare/master...richpeck:patch-1

        # => If you change this, run "rake tmp:clear" for CKEditor basepath
        config.assets.prefix = "/" + (Rails.env.development? ? Rails.env : "")

      ###########################################
      ###########################################

    end
  end
end

########################################
########################################
