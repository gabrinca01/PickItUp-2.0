 require 'uri'
 require 'net/http'
 require 'openssl'
 require 'json'
class ApplicationController < ActionController::Base
    include Pundit::Authorization
    before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:email,:num_tel,:image])
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
        user_params.permit(:username, :email,:num_tel)
    end
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:num_tel,:image])
  end
end
