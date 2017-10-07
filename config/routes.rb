########################################
########################################
##    _____            _              ##
##   | ___ \          | |             ##
##   | |_/ /___  _   _| |_ ___  ___   ##
##   |    // _ \| | | | __/ _ \/ __|  ##
##   | |\ \ (_) | |_| | ||  __/\__ \  ##
##   \_| \_\___/ \__,_|\__\___||___/  ##
##                                    ##
########################################
########################################

## Good resource
## https://gist.github.com/maxivak/5d428ade54828836e6b6#merge-engine-and-app-routes

########################################
########################################

## Routes ##
Rails.application.routes.draw do

  ########################################
  ########################################

    # => CKEditor
    mount Ckeditor::Engine => '/ckeditor' if Gem.loaded_specs.has_key? "ckeditor"

    # => ActiveAdmin
    if Gem.loaded_specs.has_key? "activeadmin"

      # => Admin
      constraints subdomain: "admin" do
        devise_for :users, ActiveAdmin::Devise.config
        ActiveAdmin.routes(self)
      end

    end

  ########################################
  ########################################

    # Index
    # => Shows index of app
    root "application#show"

    ########################################
    ########################################

    # Robots.txt
    # => https://blog.ragnarson.com/2013/11/15/hide-your-staging-environment-from-google.html
    get "robots.txt" => "application#robots", as: :robots

    ########################################
    ########################################

    # => Everything else
    # => Nodes shown through system
    resources :application, only: :show, path: "" # => url.com/:id

  ########################################
  ########################################

end
