class NewsController < ApplicationController

before_action :set_news, only: [:show, :edit, :update, :destroy]
  rescue_from Pundit::NotAuthorizedError do
    redirect_to root_path, alert: "You aren't allowed to do that"
  end
  def index
    url = URI("https://climate-news-feed.p.rapidapi.com/?source=Nasa%20Climate&limit=50&exclude=The%20Guardian")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["X-RapidAPI-Key"] = '17f85b831cmsh2c8d4e31a76ab27p1fc81cjsnf7593b684a89'
    request["X-RapidAPI-Host"] = 'climate-news-feed.p.rapidapi.com'

    response = http.request(request)
    puts response.read_body

    ris = JSON.parse(response.read_body)
    
    tem = ris.find {1}
    puts tem

    notizie = 0  
    tem.each do |neww|
      puts neww
      notizie = neww
    end

    #puts notizie

    title_ = 0;
    url_ = 0;   
    published_ = 0;   
    notizie.each do |notizia|
      n = 0  
      notizia.each do |elem|
        if n == 0
          elem.each do |t|
            title_ = t
          end

        elsif n == 1
          elem.each do |u|
            url_ = u
          end

        elsif n == 3
          elem.each do |d|
            published_ = d
          end
        end

        n=n+1;
      end
      
      puts title_
      puts url_
      puts published_

      @news = News.create(published: DateTime.parse(published_) ,title: title_ , url: url_)
    end
    
    @news = News.all.order(published: :desc)
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