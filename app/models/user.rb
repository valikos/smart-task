class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]

  has_many :projects
  has_many :tasks, through: :projects

  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end

  def self.from_omniauth(provider, oauth)
    where(provider: provider, uid: oauth['id']).first_or_create do |user|
      user.email = oauth['email']
      user.password = Devise.friendly_token[0,20]
    end
  end
end
