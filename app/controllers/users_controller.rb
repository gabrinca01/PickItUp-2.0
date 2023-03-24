class UsersController < ApplicationController
  before_action :set_user, only: [ :show,:edit, :update, :destroy]

  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @users = User.all
  end

  def show
  end

  def new
    
  end

  def create
  end

  def edit
  end

  def update
    authorize Current.user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
        
        authorize Current.user
        
        if @user.destroy
          flash[:notice] = "\"#{@user.id}\" was successfully deleted."
          redirect_to users_path,notice: "user was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the user."
          render :show
        end
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  

    # Never trust parameters from the scary internet, only allow the white list through.
    #def user_params
     # params.require(:user).permit(:username, :password, :password_confirmation, :num_tel)
    #end

   

  
end