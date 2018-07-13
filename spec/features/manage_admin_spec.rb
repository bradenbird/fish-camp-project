require 'rails_helper'

RSpec.feature "ManageAdmin", type: :feature do

  before(:each) do
    home_page.sign_in
    expect(page).to have_selector("p", text: "Signed in!")
    admin_page.visit_page
  end

  xit "it makes a user a guest" do

  end

  xit "makes a user a chair" do

  end

  xit "makes a user an admin" do

  end

  xit "accesses the update applicant page" do

  end

  xit "updates applicant fields" do

  end

  xit "deletes an applicant" do

  end

  xit "searches for applicants by name" do

  end

  xit "searches for users by name" do

  end

  xit "searches for applicants by UIN" do

  end

  xit "searches for users by email" do

  end

  xit "searches for users by role" do

  end

  xit "navigates to new pages" do

  end

end
