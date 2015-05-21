class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]

  scope :find_by_credentials, ->(params) {
    user = find_by_email(params[:email])
    if user.valid_password?(params[:password])
      user
    else
      nil
    end
  }

  def generate_auth_token
    payload = { user_id: self.id }
    AuthToken.encode(payload)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end
end
