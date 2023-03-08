class PostController < ApplicationController
  def destroy
      @post = Post.find(params[:id])
      authorize @post
      
      if @post.destroy
        flash[:notice] = "\"#{@post.id}\" was successfully deleted."
        redirect_to @post
      else
        flash.now[:alert] = "There was an error deleting the post."
        render :show
      end
  end

  def post_params
    params.require(:post).permit(:written_text, :image)
  end
end