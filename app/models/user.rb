class User < ApplicationRecord  

  has_one_attached :image
   
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :posts, -> { order(created_at: :desc) },dependent: :destroy
  has_many :challenges ,through: :join_challenges,dependent: :destroy
  has_many :likes
  has_many :follows
  has_many :join_challenges
  has_many :messages
  has_many :comments

  enum role: [:level0, :level1, :level2,:company,:admin]

  after_initialize do
    if self.new_record?
      self.role ||= :level0
      self.points ||= 0
      self.accumulated_points ||= 0
    end
  end
 

  def self.from_omniauth(auth)
  name_split = auth.info.name.split(" ")
  user = User.where(email: auth.info.email).first
  user ||= User.create!(provider: auth.provider, uid: auth.uid, last_name: name_split[0], first_name: name_split[1], email: auth.info.email, password: Devise.friendly_token[0, 20])
    user
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
