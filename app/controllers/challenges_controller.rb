class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @challenges=Challenge.all
  end

  def show
  end

  def new
    @challenge = Challenge.new
    
  end

  def create
    @challenge = Challenge.new(challenge_params)
    
    if @challenge.save
      redirect_to challenges_path, notice: "challenge was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
   
    authorize @challenge
    if @challenge.update(challenge_params)
      redirect_to challenges_path, notice: "challenge was successfully updated."
    else
      render :edit
    end
  end

  def destroy

        authorize @challenge
        
        if @challenge.destroy
          flash[:notice] = "\"#{@challenge.id}\" was successfully deleted."
          redirect_to challenges_path,notice: "challenge was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the challenge."
          render :show
        end
  end
  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def challenge_params
    params.require(:challenge).permit(:description,:luogo)
  end
  
  
end