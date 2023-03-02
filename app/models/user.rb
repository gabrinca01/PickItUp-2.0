class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, -> { order(updated_at: :desc) },dependent: :destroy
  has_many :challenges ,through: :join_challenges
  has_many :likes
  has_many :follows
  has_many :join_challenges
  has_many :messages



end
