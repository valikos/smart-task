class AuthController < ApplicationController
  skip_before_action :authenticate_request
  skip_before_action :set_current_user

  def sign_up
    begin
      user = User.new(credential_params)
      user.save
      sign_in user
      render json: { auth_token: user.generate_auth_token }
    rescue
      render json: { error: 'Invalid credentials' }, status: :unauthorized
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
