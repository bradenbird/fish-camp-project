require 'rails_helper'

RSpec.feature "AdminFeatures", type: :feature do

  context "when signing in" do
    it "signs in" do
      home_page.admin_sign_in
      expect(page).to have_selector("p", text: "Signed in as Admin!")
      admin_page.visit_page
      expect(page).to have_selector("h", text: "Fish Camp Admin Console")
    end
  end

  context "when logged in as an admin" do

    before(:each) do
      home_page.admin_sign_in
      expect(page).to have_selector("p", text: "Signed in as Admin!")
      admin_page.visit_page
      expect(page).to have_selector("h", text: "Fish Camp Admin Console")
    end

    it "it makes a user a guest" do
      other_user = create(:user, role: "admin")
      admin_page.visit_page
      admin_page.make_other_user_a_guest(other_user)
      expect(other_user.reload.role).to eq("guest")
    end

    it "makes a user a chair" do
      other_user = create(:user, role: "admin")
      admin_page.visit_page
      admin_page.make_other_user_a_chair(other_user)
      other_user.reload
      expect(other_user.role).to eq("chair")
      expect(other_user.chair.camp.name).to eq("aqua")
      expect(Session.find(other_user.chair.camp.session_id).name).to eq("E")
    end

    it "makes a user an admin" do
      other_user = create(:user, role: "guest")
      admin_page.visit_page
      admin_page.make_other_user_an_admin(other_user)
      expect(other_user.reload.role).to eq("admin")
    end

    it "accesses the update applicant page" do
      new_applicant = create(:applicant)
      admin_page.visit_page
      admin_page.visit_applicant_update_page(new_applicant)
      expect(page).to have_selector("h", text: "Fish Camp Applicant Update Page")
    end

    xit "updates applicant fields" do
      new_applicant = create(:applicant)
      admin_page.visit_page
      admin_page.update_applicant(new_applicant)
      new_applicant.reload
      expect(new_applicant.first_name).to eq("James")
      expect(new_applicant.last_name).to eq("Vanderburg")
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

    xit "pagination works" do

    end
  end
end
