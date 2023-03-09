class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
    authorize @comment
  end

  def create
    @comment = Comment.new(comment_params)
    authorize @comment
    if @comment.save
      redirect_to comments_path, notice: "comment was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @comment = Comment.find(params[:id])
    authorize @comment
    if @comment.update(comment_params)
      redirect_to comments_path, notice: "comment was successfully updated."
    else
      render :edit
    end
  end

  def destroy
        @comment = Comment.find(params[:id])
        authorize @comment
        
        if @comment.destroy
          flash[:notice] = "\"#{@comment.id}\" was successfully deleted."
          redirect_to comments_path,notice: "comment was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the comment."
          render :show
        end
  end
  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
