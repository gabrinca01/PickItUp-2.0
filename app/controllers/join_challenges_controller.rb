class JoinChallengeController < ApplicationController
  before_action :set_join_challenge, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @join_challenges = JoinChallenge.all
  end

  def show
  end

  def new
    @join_challenge = JoinChallenge.new
    authorize @join_challenge
  end

  def create
    @join_challenge = JoinChallenge.new(join_challenge_params)
    authorize @join_challenge
    if @join_challenge.save
      redirect_to join_challenges_path, notice: "join_challenge was successfully created."
    else
      render :new
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
        authorize @join_challenge
        
        if @join_challenge.destroy
          flash[:notice] = "\"#{@join_challenge.id}\" was successfully deleted."
          redirect_to join_challenges_path,notice: "join_challenge was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the join_challenge."
          render :show
        end
  end
  private

  def set_join_challenge
    @join_challenge = JoinChallenge.find(params[:id])
  end

  def join_challenge_params
    params.require(:join_challenge).permit(:nome)
  end

end