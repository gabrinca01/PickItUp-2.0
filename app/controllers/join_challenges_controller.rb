class JoinChallengeController < ApplicationController
  def destroy
      @join_challenge = JoinChallenge.find(params[:id])
      authorize @join_challenge
      
      if @join_challenge.destroy
        flash[:notice] = "\"#{@join_challenge.id}\" was successfully deleted."
        redirect_to @join_challenge
      else
        flash.now[:alert] = "There was an error deleting the join_challenge."
        render :show
      end
  end
end