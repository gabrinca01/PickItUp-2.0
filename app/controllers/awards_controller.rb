class AwardsController < ApplicationController
  before_action :set_award, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @awards = Award.all
  end

  def show
  end

  def new
    @award = Award.new
    authorize @award
  end

  def create
    @award = Award.new(award_params)
    authorize @award
    if @award.save
      redirect_to awards_path, notice: "award was successfully created."
    else
      render :new
    end
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
        authorize @award
        
        if @award.destroy
          flash[:notice] = "\"#{@award.id}\" was successfully deleted."
          redirect_to awards_path,notice: "award was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the award."
          render :show
        end
  end
  private

  def set_award
    @award = Award.find(params[:id])
  end

  def award_params
    params.require(:award).permit(:nome)
  end

end