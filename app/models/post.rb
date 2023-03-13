class Post < ApplicationRecord
	belongs_to :user
	has_many_attached :images
	has_many_attached :videos
	attribute :image, :string, default: ''
end