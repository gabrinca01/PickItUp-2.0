class NewsController < ApplicationController
before_action :set_news, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    @news = News.all
  end

  def show
  end

  def new
    @news = News.new
    authorize @news
  end

  def create
    @news = News.new(news_params)
    authorize @news
    if @news.save
      redirect_to news_path, notice: "news was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @news = News.find(params[:id])
    authorize @news
    if @news.update(news_params)
      redirect_to news_path, notice: "news was successfully updated."
    else
      render :edit
    end
  end

  def destroy
        @news = News.find(params[:id])
        authorize @news
        
        if @news.destroy
          flash[:notice] = "\"#{@news.id}\" was successfully deleted."
          redirect_to news_path,notice: "news was successfully destroyed."
        else
          flash.now[:alert] = "There was an error deleting the news."
          render :show
        end
  end
  private

  def set_news
    @news = News.find(params[:id])
  end

  def news_params
    params.require(:news).permit(:nome)
  end
end