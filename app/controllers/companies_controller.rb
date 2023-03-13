class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = Company.new
    authorize @company
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      redirect_to companies_path, notice: "company was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @company = Company.find(params[:id])
    authorize @company
    if @company.update(company_params)
      redirect_to companies_path, notice: "company was successfully updated."
    else
      render :edit
    end
  end

  def destroy
        @company = Company.find(params[:id])
        authorize @company
        
        if @company.destroy
          flash[:notice] = "\"#{@company.id}\" was successfully deleted."
          redirect_to companies_path,notice: "company was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the company."
          render :show
        end
  end
  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:nome)
  end

end