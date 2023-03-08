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

  enum role: [:level0, :level1, :level2,:admin]

  after_initialize do
    if self.new_record?
      self.role ||= :level0
      self.points ||= 0
      self.accumulated_points ||= 0
    end
  end
 

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
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
