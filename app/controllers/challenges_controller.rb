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
    lat = @challenge.luogo.split(',')[0] 
    long = @challenge.luogo.split(',')[1]
    rad  =@challenge.raggio.to_s 
    @l =lat+':'+long+':'+rad  
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
    durata = params[:challenge][:durata].to_i 
    @challenge.durata = durata
      assign_points(@challenge)
      
      year=params[:challenge]['def_time(1i)'].to_i 
      

      month=params[:challenge]["def_time(2i)"].to_i

      day=params[:challenge]['def_time(3i)'].to_i
      hour=params[:challenge]['def_time(4i)'].to_i
      minute=params[:challenge]['def_time(5i)'].to_i
      date_time1=DateTime.new(year,month,day,hour,minute,0)
      date_time2 = date_time1 + (durata/2).hours
      date_time3 = date_time1 + durata.hours
      @challenge.date_time1=date_time1
      @challenge.date_time2=date_time2
      @challenge.date_time2=date_time3
      @challenge.send_messages
      redirect_to @challenge, notice: "You set the definite details successfully"
  end
  def assign_points (challenge)
      ratio  = challenge.raggio.to_f / challenge.num_partecipanti 
      challenge.points = ratio
      challenge.save
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