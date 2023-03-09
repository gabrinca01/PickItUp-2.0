class MessageController < ApplicationController
 before_action :set_message, only: [:show, :edit, :update, :destroy]
 rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @messages = Message.all
  end

  def show
  end

  def new
    @message = Message.new
    authorize @message
  end

  def create
    @message = Message.new(message_params)
    authorize @message
    if @message.save
      redirect_to messages_path, notice: "message was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @message = Message.find(params[:id])
    authorize @message
    if @message.update(message_params)
      redirect_to messages_path, notice: "message was successfully updated."
    else
      render :edit
    end
  end

  def destroy
        @message = Message.find(params[:id])
        authorize @message
        
        if @message.destroy
          flash[:notice] = "\"#{@message.id}\" was successfully deleted."
          redirect_to messages_path,notice: "message was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the message."
          render :show
        end
  end
  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:nome)
  end
end