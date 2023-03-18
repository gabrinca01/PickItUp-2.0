class Message < ApplicationRecord
	belongs_to :challenge
	belongs_to :user
	after_create_commit { broadcast_append_to self.challenge }
end