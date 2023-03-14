 require 'uri'
 require 'net/http'
 require 'openssl'
 require 'json'
class ApplicationController < ActionController::Base
    include Pundit::Authorization
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :initialize_component_context

    def initialize_component_context
        Current.user = current_user
    end

    

  protected


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:num_tel,:email,:password,:password_confirmation])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
        user_params.permit(:email,:username)
    end
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:image])
  end
end
