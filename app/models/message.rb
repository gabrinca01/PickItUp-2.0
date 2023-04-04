class Message < ApplicationRecord
	belongs_to :challenge
	belongs_to :user
	validates :msg_txt,length: { minimum: 1 }
	after_create_commit { broadcast_append_to self.challenge }
end