module LoginHelper
  def skip_auth(user_args = {})
    user = FactoryGirl.create(:user, user_args)
    allow_any_instance_of(::AuthorizationHeader)
      .to receive(:content).and_return(user.generate_auth_token)
  end
end
