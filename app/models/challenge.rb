class Challenge < ApplicationRecord
	#has_and_belongs_to_many :join_challenges
	has_one :user
	has_many :join_challenges,dependent: :destroy
	
end