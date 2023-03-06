class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
  has_many :posts, -> { order(updated_at: :desc) },dependent: :destroy
  has_many :challenges ,through: :join_challenges
  has_many :likes
  has_many :follows
  has_many :join_challenges
  has_many :messages



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
