class User < ApplicationRecord  

  has_one_attached :image
  #validates :role, inclusion: { in: %w(level0 level1 level2 company admin),
 #  message: "%{value} is not a valid role" }
  validates :username, presence: true, uniqueness: true
  validates :email,presence:true,uniqueness:true
  validates :num_tel, presence: true, uniqueness: true
  

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :posts, -> { order(created_at: :desc) },dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :join_challenges,dependent: :destroy
  has_many :messages,dependent: :destroy
  has_many :comments,dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  def to_json(options={})
    options[:except] ||= [:verified]
    super(options)
  end
  

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]
      ["extra"]["raw_info"]
         user.email = data["email"] if user.email.blank?
      end
    end
  end
   # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end




end
