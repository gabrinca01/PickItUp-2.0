# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  #before_action :set_user, only: [ :verify]
  before_action :set_client, only: [:create, :verify]
  
  # GET /resource/sign_up
   #
  def new
   super
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        start_verification(resource.num_tel, params[:channel])
        redirect_to verify_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :new
    end
  end

  # GET /resource/edit
  # def edit
   # super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end
  def verify
    @user= current_user
    if request.post?
      is_verified = check_verification(@user.num_tel, params['verification_code'])
      if is_verified
        @user.verified = true
        @user.save
        
        respond_to do |format|
          format.html { redirect_to root_path, notice: 'User was successfully verified.' }
        end
      else
        respond_to do |format|
          format.html { redirect_to verify_path, notice: 'The code was invalid.' }
        end
      end
    else
    end
  end

   protected

  # If you have extra params to permit, append them to the sanitizer.
   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:num_tel,:email,:password,:password_confirmation])
   end

  # If you have extra params to permit, append them to the sanitizer.
   def configure_account_update_params
     devise_parameter_sanitizer.permit(:account_update, keys: [:image,:username,:accumulated_points,:role])
   end
   def start_verification(to, channel='sms')
      channel = 'sms' unless ['sms', 'voice'].include? channel
      verification = @client.verify.services(ENV['VERIFICATION_SID'])
                                   .verifications
                                   .create(:to => to, :channel => channel)
      return verification.sid
    end
    def check_verification(phone, code)
      verification_check = @client.verify.services(ENV['VERIFICATION_SID'])
                                         .verification_checks
                                         .create(:to => phone, :code => code)
      return verification_check.status == 'approved'
    end
  # The path used after sign up.
    

   #The path used after sign up for inactive accounts.
   
  #def set_user
   # @user= User.find(params[:id])
  #end

  def set_client
      @client = Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end
  def sign_up_params
    params.require(:user).permit(:username,:email , :password, :password_confirmation,:num_tel,:image)
  end  
  
   
end
