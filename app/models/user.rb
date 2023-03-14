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
  #has_many :challenges ,through: :join_challenges,dependent: :destroy
  has_many :likes
  has_many :follows
  #has_many :join_challenges
  has_many :messages
  has_many :comments

  
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



end
