#encoding: utf-8
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

# => Constants
require_relative 'lib/fl/constants'

##############################################################
##############################################################

## Specs ##
Gem::Specification.new do |spec|

    ## Info ##
    spec.name          = "fl"
    spec.authors       = ["R.Peck"]
    spec.email         = ["rpeck@fl.co.uk"]
    spec.homepage      = FL::COMPANY::URL
    spec.version       = FL::VERSION::STRING
    spec.platform      = Gem::Platform::RUBY

    ## Summary ##
    spec.summary       = %q{FL Framework for Rails → Helpers / Frontend}
    spec.description   = %q{FL Framework for Rails → Helpers / Frontend}

  ##############################################################
  ##############################################################

    ## Files ##
    spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
    spec.bindir        = "exe"
    spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
    spec.require_paths = ["lib"]

  ##############################################################
  ##############################################################

    ## Dev ##
    spec.add_development_dependency 'bundler', '~> 1.16'
    spec.add_development_dependency 'rake',    '~> 10.0'

    ## Prod ##
    spec.add_dependency 'rails',     '>= 5'             # => Rails
    spec.add_dependency 'sprockets', '~> 4.0.0.beta4', '< 4.0.0.beta5'  # => Sprockets (beta7 works in development but not heroku)
    spec.add_dependency 'autoprefixer-rails'            # => Autoprefixer
    spec.add_dependency 'font-awesome-rails'            # => Icons
    spec.add_dependency 'activeadmin'                   # => ActiveAdmin
    spec.add_dependency 'formadmin'                     # => FormAdmin (ActiveAdmin Skin)
    spec.add_dependency 'activeadmin_addons'            # => ActiveAdmin addons

    ## Backend ##
    spec.add_dependency 'bootstrap', '~> 4.1.1' # => Bootstrap (tooltips)
    spec.add_dependency 'liquid'                        # => Liquid
    spec.add_dependency 'ckeditor'                      # => CKEditor
    spec.add_dependency 'nilify_blanks'                 # => Nilify Blanks
    spec.add_dependency 'paperclip'                     # => Paperclip
    spec.add_dependency 'rmagick'                       # => RMagick
    spec.add_dependency 'friendly_id'                   # => FriendlyID
    spec.add_dependency 'devise'                        # => Devise
    spec.add_dependency 'exception_handler'             # => ExceptionHandler
    spec.add_dependency 'responders'                    # => Responders (used in controller)

  ##############################################################
  ##############################################################

end
