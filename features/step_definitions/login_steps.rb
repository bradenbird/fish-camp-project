When(/^I am not logged in and I visit the homepage$/) do
  visit root_path
end

Then(/^I should see the link to login$/) do
  expect(page).to have_content("Sign in with Google")
end

When(/^I am logged in and visit the homepage$/) do
  visit "/auth/google_oauth2/"
end

Then(/^I should see the link to signout$/) do
  expect(page).to have_content("Sign out")
end