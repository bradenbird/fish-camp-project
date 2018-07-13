require 'rails_helper'

RSpec.feature "ManageAdmin", type: :feature do

  # before(:each) do
  #   home_page.sign_in
  #   expect(page).to have_selector("p", text: "Signed in!")
  #   admin_page.visit_page
  # end

  it "signs in" do
    home_page.sign_in
    expect(page).to have_selector("p", text: "Signed in as James Vanderburg!")
  end

  it "signs in and goes to admin page" do
    home_page.sign_in
    expect(page).to have_selector("p", text: "Signed in as James Vanderburg!")
    admin_page.visit_page
    expect(page).to have_selector("h", text: "Fish Camp Admin Console")
  end

end
