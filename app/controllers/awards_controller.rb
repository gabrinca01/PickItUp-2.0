class AwardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_award, only: [:show, :edit, :update, :destroy]
  before_action :set_award_buy, only: [:buy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @awards = Award.all
    @award = Award.new
  end

  def show
  end

  def new
    @award = Award.new
    
  end

  def create
    @award = Award.new(award_params)
    @award.save
    redirect_to awards_path, notice: "award was successfully created."
  end

  def edit
  end

  def update
    @award = Award.find(params[:id])
    authorize @award
    if @award.update(award_params)
      redirect_to awards_path, notice: "award was successfully updated."
    else
      render :edit
    end
  end

  def destroy
        @award = Award.find(params[:id]) 
        if @award.destroy
          flash[:notice] = "\"#{@award.id}\" was successfully deleted."
          redirect_to awards_path,notice: "award was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the award."
          render :show
        end
  end
  def buy
    @award.left -= 1
    if @award.left == 0
      @award.destroy
    else
      @award.save
    end
    if current_user.points
      current_user.points -= @award.price
      if current_user.points <= 0
        flash[:notice] = "You don't have enough points to buy this award!Go do another challenge"
      else
        current_user.save
      end
    end
    redirect_to awards_path

  end
  private

  def set_award
    @award = Award.find(params[:id])
  end
  def set_award_buy
    @award = Award.find(params[:format])
  end
  def award_params
    params.require(:award).permit(:user_id,:image,:price,:description,:left)
  end

end