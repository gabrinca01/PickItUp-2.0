class CompanyController < ApplicationController
  def destroy
      @company = Company.find(params[:id])
      authorize @company
      
      if @company.destroy
        flash[:notice] = "\"#{@company.id}\" was successfully deleted."
        redirect_to @company
      else
        flash.now[:alert] = "There was an error deleting the company."
        render :show
      end
  end
end