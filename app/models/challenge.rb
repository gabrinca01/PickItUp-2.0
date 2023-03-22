class Challenge < ApplicationRecord
	#has_and_belongs_to_many :join_challenges
	has_one :user
	has_many :join_challenges,dependent: :destroy
	has_many :messages,dependent: :destroy
	attr_accessor :date_time1
	attr_accessor :date_time2
	attr_accessor :date_time3
	def send_messages 
	    @users =Array.new  
	    this.join_challenges.each do |join|
	      @users.push(User.find(join.user_id))
	    end
	    @users.each do |user|
	      url = URI("https://inteltech.p.rapidapi.com/send.php")

	      http = Net::HTTP.new(url.host, url.port)
	      http.use_ssl = true
	      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

	      request = Net::HTTP::Post.new(url)
	      request["content-type"] = 'application/x-www-form-urlencoded'
	      request["X-RapidAPI-Key"] = 'dd42f26b3emshac94e324c873f7bp132f7cjsn86b7b4d80c16'
	      request["X-RapidAPI-Host"] = 'inteltech.p.rapidapi.com'
	      request.body = "sms=%2B"+user.num_tel.tr('+', '')+"&message=Upload%20pictures%20and%20videos%20of%20your%20challenge%20by%20clicking%20on%20this%20link&senderid=MyCompany&schedule=1377959755&return=http%3A%2F%2Fyourwebsite.com&key=D63A0EB8-E2C9-28F5-B5C3-65368D003C8F&username=gabrincarbone%40gmail.com"

	      response = http.request(request)
	      puts response.read_body
	    end 
  end
	handle_asynchronously :send_messages,:run_at => @date_time1
    handle_asynchronously :send_messages,:run_at => @date_time2
    handle_asynchronously :send_messages,:run_at => @date_time3

 
end