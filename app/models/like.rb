class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  after_create_commit { broadcast_prepend_to [post, :likes], target: "#{dom_id(post)}_likes" }
end
