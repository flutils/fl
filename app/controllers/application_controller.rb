class ApplicationController < ActionController::Base

  ##################################
  ##################################

    # => Responders Gem
    respond_to :html

  ##################################
  ##################################

    # => Settings
    # Header & Footer content defined in ApplicationHelper
    protect_from_forgery with: :exception

    # => Layout
    layout Proc.new { |c| Rails.application.secrets[:app][:layout] || 'base' unless c.request.xhr? }

    # => Maintenance
    before_action Proc.new { @maintenance = Node.find_by(ref: "maintenance").try(:val) }, only: :show

  ##################################
  ##################################

    # => Specific page content
    # => All slugrouter requests passed here (including root)
    # => Liquid ref - https://github.com/Shopify/liquid/wiki/Liquid-for-Programmers#first-steps
    # => If not using bang operator in find, use || "No Content"
    def show
      raise ActionController::RoutingError.new('Not Found') if params[:id] == "index"
      @content = Node.find_by_slug! params[:id] || "index"
    end

  ##################################
  # => Auth
  ##################################

    # => New
    def new
      @content = Node.new
      respond_with @content
    end

    # => Create
    def create
      @content = Node.new node_params
      respond_with @content, location: -> { application_path(@content) }
    end

    # => Update
    def update
      @content = Node.find_by_slug! params[:id]
      respond_with @content, location: -> { application_path(@content) }
    end

  ##################################
  ##################################

    # => Robots.txt
    # => http://api.rubyonrails.org/classes/ActionController/ConditionalGet.html#method-i-expires_in
    def robots
      expires_in 5.hours, public: true
      render plain: "User-agent: *"
    end

  ##################################
  ##################################

  private

    # => Devise
    # => Sign In
    def after_sign_in_path_for(resource)
      Rails.application.routes.named_routes[:admin_root] ? admin_root_path : root_path
    end

    # => Devise
    # => Sign Out
    def after_sign_out_path_for(resource_or_scope)
      root_path
    end

    # => Params
    def node_params
      params.require(:node).permit(:ref, :val)
    end

 ##################################

end
