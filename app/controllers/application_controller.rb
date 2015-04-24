class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resources)
    user_path(resource) || root_path
  end

  def after_sign_up_path_for(resources)
    user_path(resource) || root_path
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  include RecommendationsHelper

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << [
      :username, :pone, :first_name, :last_name,
      :zip_code, :profile_pic, :remote_profile_pic_url, :about_me, :skill_list, :interest_list
      ]
    devise_parameter_sanitizer.for(:sign_up) << [
      :username, :pone, :first_name, :last_name,
      :zip_code, :profile_pic, :remote_profile_pic_url, :about_me, :skill_list, :interest_list
      ]
  end
end
