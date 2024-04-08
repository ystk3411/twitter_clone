# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[telephone_number birth_day name])
  end

  def after_sign_in_path_for(_resource)
    tweets_path
  end

  def after_sign_out_path_for(_resource)
    tweets_path
  end
end
