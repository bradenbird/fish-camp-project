require 'rails_helper'

RSpec.feature "ChairFeatures", type: :feature do
  it "signs in" do
    home_page.chair_sign_in
    expect(page).to have_selector("p", text: "Signed in as Chair!")
    chair_page.visit_page
    expect(page).to have_selector("h", text: "Fish Camp Applicant Database")
  end

  context "when signed in as a chair" do
    xit "cannot view applicants not available for their session" do
      # set up factory
    end

    context "it views an application" do
      it "clicks on UIN link" do
        chair_page.click_first_uin
        expect(page).to have_selector("h", text: "Fish Camp Applicant")
      end

      xit "finds by UIN search" do
        # set up factory
      end

      xit "does not show an error message when using UIN search" do
        # set up factory
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
