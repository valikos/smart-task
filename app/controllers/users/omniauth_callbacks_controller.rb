class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :set_current_user
  skip_before_action :authenticate_request

  def facebook
    binding.pry
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      respond_to do |format|
        format.json do
          # sign_in(@user)
          render :status => 200, json: { auth_token: user.generate_auth_token }
          # :json => { :user => { :email => @user.email, :name => @user.name } }
        end
      end
    else
      respond_to do |format|
        format.json do
          render :status => 401, :json => { :errors => alert }
        end
      end
    end
  end
end

__END__

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in(@user)

      render :status => 200, :json => { :user => { :email => @user.email, :name => @user.name } }
    else
      render :status => 401, :json => { :errors => alert }
    end
  end
end