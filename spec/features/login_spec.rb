require 'feature_helper'

feature 'I want to be able to sign in', js: true do
  let(:user) { FactoryGirl.create :user }

  background do
    @sign_in = SignInPage.new
  end

  scenario 'by email/password' do
    @sign_in.load

    @sign_in.email_field.set user.email
    @sign_in.password_field.set user.password
    @sign_in.credentials_submit.click

    expect(@sign_in).to have_text 'Sign Out'
  end
end

feature 'I want to be able to sign up', js: true do
  let(:user) { FactoryGirl.build :user }

  background do
    @sign_up = SignUpPage.new
  end

  scenario 'by email/password' do
    @sign_up.load

    @sign_up.email_field.set user.email
    @sign_up.password_field.set user.password
    @sign_up.credentials_submit.click

    expect(@sign_up).to have_text 'Sign Out'
  end
end
