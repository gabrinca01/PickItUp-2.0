class HomeController < ApplicationController
  
  before_action :authenticate_user!
  def index
    @posts = Post.where.not(user_id: current_user.id)
    @awards = Award.all
  end
end
