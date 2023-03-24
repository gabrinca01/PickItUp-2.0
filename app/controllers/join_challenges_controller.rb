class JoinChallengesController < ApplicationController
  #before_action :set_join_challenge, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to challenges_path, alert: "You aren't allowed to do that"
  end
  def index
    @join_challenges = JoinChallenge.all
  end

  def show
  end

  def new
  end

  def create
    @join_challenge = JoinChallenge.new
    @join_challenge.challenge_id = params[:join_challenge][:challenge_id]
    @join_challenge.user_id = current_user.id
    if @join_challenge.save
      redirect_to challenges_path,challenge_id: params[:id], notice: "You can chat with other Challenge memebers now"
    else

      redirect_to root_path, notice: "join challenge was not created successfully"
    end
  end

  def edit
  end

  def update
    @join_challenge = JoinChallenge.find(params[:id])
    authorize @join_challenge
    if @join_challenge.update(join_challenge_params)
      redirect_to join_challenges_path, notice: "join_challenge was successfully updated."
    else
      render :edit
    end
  end

  def destroy
        @join_challenge = JoinChallenge.find(params[:id])
        
        
        if @join_challenge.destroy
          flash[:notice] = "\"#{@join_challenge.id}\" was successfully deleted."
          redirect_to join_challenges_path,notice: "join_challenge was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the join_challenge."
          render :show
        end
  end
  private

 
  

end