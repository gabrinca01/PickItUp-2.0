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
    
    #puts "---------- put dell'array-----------"
  
    #ris.each do |article|
      
    #  puts "-----------ciclo principale------------"
      
    #  article.each do |elem|
        
    #    puts elem
    #    puts "----------------------------------------"
          
    #  end
      
      #puts article
      #@news = News.create(published: DateTime.parse(article.published) ,title: article.title , url: article.url)

    
    #end

    puts "-----------------------aaaa-----------------------"
    tem = ris.find {1}
    news = tem.find {9}
    puts tem

    notizie = 0
    puts "-----------------------aaaa-----------------------"
    tem.each do |neww|

      puts neww

      notizie = neww
      puts "---------------------------------------------fffff------------------------------"
    end

    puts "---------------------stampo notizie--------------------------"
    puts notizie

    notizie.each do |notizia|
      puts "-----------nn---------------"
      puts notizia[:title]
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