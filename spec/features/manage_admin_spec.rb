require 'rails_helper'

RSpec.feature "ManageAdmin", type: :feature do

  def setup
    # TODO: seed with some static data to make tests more consistent
    load "#{Rails.root}/db/seeds.rb"
  end

  # setup

  context "when logged in as an admin" do

    # before(:each) do
    #   home_page.admin_sign_in
    #   expect(page).to have_selector("p", text: "Signed in as Admin!")
    #   admin_page.visit_page
    #   expect(page).to have_selector("h", text: "Fish Camp Admin Console")
    # end

    it "signs in" do
      home_page.admin_sign_in
      expect(page).to have_selector("p", text: "Signed in as Admin!")
      admin_page.visit_page
      expect(page).to have_selector("h", text: "Fish Camp Admin Console")
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

    xit "pagination works" do

    end

  end

  context "when signed in as a chair" do
    xit "cannot view applicants not available for their session" do

    end

    context "it views an application" do
      xit "clicks on UIN link" do

      end

      xit "finds by UIN search" do

      end

      xit "does not show an error message when using UIN search" do

      end
    end

    context "when writing interviews" do
      xit "navigates to interview page" do

      end

      xit "saves an interview" do

      end
    end
  end
end
