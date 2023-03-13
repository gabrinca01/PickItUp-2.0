class HomeController < ApplicationController
  
  before_action :authenticate_user!
  protect_from_forgery prepend: true
  def index
    @awards = Award.all
    @timeline_posts = Post.all.where.not(user_id: Current.user.id)


     

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
