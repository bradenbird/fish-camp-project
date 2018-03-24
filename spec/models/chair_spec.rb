require 'rails_helper'

RSpec.describe Chair, type: :model do
  # let(:sessiona) { create(:session, name: "A") }

  it "has a valid factory" do
    expect(create(:chair)).to be_valid
  end
  it "is invalid without a camp" do
    expect(build(:chair, camp: nil)).to_not be_valid
  end
  it "is invalid without a user" do
    expect(build(:chair, user: nil)).to_not be_valid
  end

  describe "#applicants" do
    it "gets all applicants for the chair's session" do
      sessiona = create(:session, name: "A")
      sessionb = create(:session, name: "B")
      chair = create(:chair, camp: create(:camp, session: sessiona))
      applicant1 = create(:applicant)
      applicant1.session_availabilities.create(session: sessiona)
      applicant2 = create(:applicant)
      applicant2.session_availabilities.create(session: sessiona)
      applicant2.session_availabilities.create(session: sessionb)
      applicant3 = create(:applicant)
      applicant3.session_availabilities.create(session: sessionb)
      expect(chair.applicants).to contain_exactly(applicant1, applicant2)
    end
  end
end
