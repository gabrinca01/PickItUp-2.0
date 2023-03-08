class AwardController < ApplicationController
  def destroy
      @award = Award.find(params[:id])
      authorize @award
      
      if @award.destroy
        flash[:notice] = "\"#{@award.id}\" was successfully deleted."
        redirect_to @award
      else
        flash.now[:alert] = "There was an error deleting the award."
        render :show
      end
  end
end