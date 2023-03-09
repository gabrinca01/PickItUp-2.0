class PostController < ApplicationController
  before_action :post, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)
    authorize @post
    if @post.save
      redirect_to posts_path, notice: "post was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update(post_params)
      redirect_to posts_path, notice: "post was successfully updated."
    else
      render :edit
    end
  end

  def destroy
        @post = Post.find(params[:id])
        authorize @post
        
        if @post.destroy
          flash[:notice] = "\"#{@post.id}\" was successfully deleted."
          redirect_to posts_path,notice: "post was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the post."
          render :show
        end
  end
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:nome)
  end
end