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
  end
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.turbo_stream { render turbo_stream: turbo_stream.replace('comment_form', partial: 'comments/form', locals: { comment: Comment.new }) }
        format.html { render partial: 'comments/form', locals: { comment: Comment.new }}
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('comment_form', partial: 'comments/form', locals: { comment: @comment }) }
        format.html { render partial: 'comments/form', locals: { comment: comment }}
      end
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
