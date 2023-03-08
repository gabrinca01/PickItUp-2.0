class MessageController < ApplicationController
  def destroy
      @message = Message.find(params[:id])
      authorize @message
      
      if @message.destroy
        flash[:notice] = "\"#{@message.id}\" was successfully deleted."
        redirect_to @message
      else
        flash.now[:alert] = "There was an error deleting the message."
        render :show
      end
  end
end