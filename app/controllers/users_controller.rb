class UsersController < ApplicationController
  before_action :set_user, only: [ :show,:edit, :update, :destroy]
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @users = User.all
  end

  def show
    @posts = Post.where(user_id: @user.id, verified: true)
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

  

    

   

  
end