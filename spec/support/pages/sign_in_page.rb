class SignInPage < SitePrism::Page
  set_url '#/sign_in'

  element :email_field,        '.credentials-email'
  element :password_field,     '.credentials-password'
  element :credentials_submit, '.credentials-submit'
  element :facebook_auth,      '#fb-sign-in'
end
