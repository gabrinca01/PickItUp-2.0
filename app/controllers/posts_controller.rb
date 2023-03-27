class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy,:verify]
  #before_action :set_challenge, only: [:verify]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    
    if params['commit'] != 'Post'
      @pictures = params['post']['images']
      @pictures.each do |picture|
        PictureAttachmentService.attach(@post,picture)
      end
      @post.verified = false
    else
      @post.verified = true
      @post.images.attach(params['post']['images'])
    end
    respond_to do |format|
    if @post.save
      format.html { redirect_to root_path, notice: 'post was successfully updated.' }
      format.json { render :show, status: :ok, location: @post }
      
    else
      render :new
    end
    end
    
      
  end

  def edit
  end

  def update
    
    if @post.update(post_params)
      redirect_to posts_path, notice: "post was successfully updated."
    else
      render :edit
    end
  end

  def destroy
        
        authorize @post
        
        if @post.destroy
          flash[:notice] = "\"#{@post.id}\" was successfully deleted."
          redirect_to posts_path,notice: "post was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the post."
          render :show
        end
  end

  def to_verify
    @to_verify_posts = Post.where(verified: false)
  end
  def verify
    @post.verified = true
    @post.save
    @points = Challenge.find(@post.challenge_id).points
    @user = User.find(@post.user_id)
    @user.points += @points
    @user.accumulated_points += @points
    @user.save 
    redirect_to verify_path 
  end
 
  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:written_text)
  end
end