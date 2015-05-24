class AuthController < ApplicationController
  skip_before_action :authenticate_request
  skip_before_action :set_current_user

  def sign_up
    user = User.new(credential_params)
    if user.save
      sign_in user
      render json: { auth_token: user.generate_auth_token }
    else
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      sign_in user
      render json: { auth_token: user.generate_auth_token }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def credential_params
    params.require(:auth).permit(:email, :password)
  end
end
