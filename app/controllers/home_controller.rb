class HomeController < ApplicationController
  
  before_action :authenticate_user!
  protect_from_forgery prepend: true
  def index
    @post = Post.new 
    @follows  = current_user.following.select(:followed_id)
    @timeline_posts = Post.where(verified: true).where("user_id in (?)", @follows)
  end
  def search
    if params[:search].blank?
      redirect_to home_path and return
    else
      @parameter = params[:search].downcase
      @results = User.all.where("lower(username) LIKE :search", search: "%#{@parameter}%")
    end
  end

end
