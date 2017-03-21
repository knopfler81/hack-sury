class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  layout :layout_by_resource

  # include Pundit
  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit

  private

  # def skip_pundit?
  #   devise_controller? #|| params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  # end

  def layout_by_resource
    if (params[:controller] == "registrations" && params[:action] == "new") ||
        (params[:controller] == "devise/sessions" && params[:action] == "new") ||
        (params[:controller] == "devise/passwords" && params[:action] == "new")
      "devise"
    else
      "application"
    end
  end
end


