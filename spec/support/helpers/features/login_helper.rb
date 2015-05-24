module LoginHelper
  def skip_auth(user_args = {})
    user = FactoryGirl.create(:user, user_args)
    stub_auth_header(user)
  end

  def skip_auth_for(user)
    stub_auth_header(user)
  end

  private

  def stub_auth_header(user)
    allow_any_instance_of(::AuthorizationHeader)
      .to receive(:content).and_return(user.generate_auth_token)
  end
end
