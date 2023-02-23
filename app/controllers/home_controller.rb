class HomeController < ApplicationController
  
  before_action :authenticate_user!
  def index
   

=begin 
    url = URI("https://you-chat-gpt.p.rapidapi.com/")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["X-RapidAPI-Key"] = 'dd42f26b3emshac94e324c873f7bp132f7cjsn86b7b4d80c16'
    request["X-RapidAPI-Host"] = 'you-chat-gpt.p.rapidapi.com'
    request.body = "{\r\n    \"question\": \"Will artificial intelligence replace software developers?\",\r\n    \"max_response_time\": 30\r\n}"
    @response = http.request(request)
    if @response != nil
      @response= @response.read_body
      @response = JSON.parse(@response)
      @response = @response['answer']
    end
=end
  end
end
