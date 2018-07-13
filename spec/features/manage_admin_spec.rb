require 'rails_helper'

RSpec.feature "ManageAdmin", type: :feature do

  # before(:each) do
  #   home_page.sign_in
  #   expect(page).to have_selector("p", text: "Signed in!")
  # end

  it "signs in" do
    home_page.sign_in
    expect(page).to have_selector("p", text: "Signed in as James Vanderburg!")
  end

end
