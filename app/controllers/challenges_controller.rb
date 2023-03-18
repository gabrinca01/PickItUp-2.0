class ChallengesController < ApplicationController
  before_action :set_challenge, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index  
    @message = Message.new  
    @joined_challenges = Challenge.joins(:join_challenges).where(user_id: current_user.id)

  end

  def show
    @joined_challenges = Challenge.joins(:join_challenges).where(user_id: current_user.id)
    @messages = @challenge.messages
    @message = Message.new
    render :index
  end

  def new
    @challenge = Challenge.new
  end

  def create
    
    @challenge = Challenge.new(challenge_params)
    @challenge.num_partecipanti = 1
    
    if @challenge.save 
      @join_challenge=JoinChallenge.new
      @join_challenge.challenge_id = @challenge.id
      @join_challenge.user_id = @challenge.user_id
      if @join_challenge.save
      redirect_to @challenge, notice: "challenge was successfully created."
      end
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
    params.require(:challenge).permit(:user_id,:description,:luogo,:raggio,:temp_time,:temp_date)
  end
  

  
  
end