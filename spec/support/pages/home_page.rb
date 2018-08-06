class HomePage < Page
  include Capybara::DSL
  include OmniauthMacros

  def admin_sign_in
    visit '/'
    admin_auth_hash
    click_on 'Sign in with Google'
  end

  def chair_sign_in
    visit '/'
    chair_auth_hash
    click_on 'Sign in with Google'
  end

end
