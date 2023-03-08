class ChallengesController < ApplicationController
  def destroy
      @challenge = Challenge.find(params[:id])
      authorize @challenge
      
      if @challenge.destroy
        flash[:notice] = "\"#{@challenge.id}\" was successfully deleted."
        redirect_to @challenge
      else
        flash.now[:alert] = "There was an error deleting the challenge."
        render :show
      end
  end
end