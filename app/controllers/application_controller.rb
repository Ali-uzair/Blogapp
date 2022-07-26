# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # include Pundit::Authorization
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name avatar moderator])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[name avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name avatar])
  end
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'you are not authorized to perform this action'
    redirect_to(request.referer || root_path)
  end

  def after_sign_in_path_for(_resource)
    posts_url
  end

  def file_not_found
    render file: Rails.root.join('/public/404').to_s, layout: false, status: :not_found
  end
end
