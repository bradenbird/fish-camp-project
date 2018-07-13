class HomePage < Page
  include Capybara::DSL
  include OmniauthMacros

  def sign_in
    visit '/'
    mock_auth_hash
    click_on 'Sign in with Google'
  end
end
