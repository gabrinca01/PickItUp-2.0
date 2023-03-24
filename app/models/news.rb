class News < ApplicationRecord
	validates :title,uniqueness: true
end