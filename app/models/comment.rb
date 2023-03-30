class Comment < ApplicationRecord
	include ActionView::RecordIdentifier
	belongs_to :post
	belongs_to :user
	validates :body,length: { minimum: 1 }

after_create_commit { broadcast_prepend_to [post, :comments], target: "#{dom_id(post)}_comments" }
end
