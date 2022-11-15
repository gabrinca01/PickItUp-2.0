class User < ActiveRecord::Base
	validates :email, uniqueness: true
	validates :username, uniqueness: true


end
