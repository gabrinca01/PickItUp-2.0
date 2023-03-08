class UserController < ApplicationController
  def destroy
      @user = User.find(params[:id])
      authorize @user
      
      if @user.destroy
        flash[:notice] = "\"#{@user.id}\" was successfully deleted."
        redirect_to @user
      else
        flash.now[:alert] = "There was an error deleting the user."
        render :show
      end
  end

  def user_params
    params.require(:user).permit(:image)
  end
end