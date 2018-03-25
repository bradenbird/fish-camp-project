require 'rails_helper'

RSpec.describe Chair, type: :model do
  let(:sessiona) { create(:session, name: "A") }
  let(:sessionb) { create(:session, name: "B") }
  let(:applicant1) { create(:applicant) }
  let(:applicant2) { create(:applicant) }
  let(:applicant3) { create(:applicant) }

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
      chair = create(:chair, camp: create(:camp, session: sessiona))
      applicant1.session_availabilities.create(session: sessiona)
      applicant2.session_availabilities.create(session: sessiona)
      applicant2.session_availabilities.create(session: sessionb)
      applicant3.session_availabilities.create(session: sessionb)
      expect(chair.applicants).to contain_exactly(applicant1, applicant2)
    end
  end

  describe "#unevaluated_applicants" do
    it "gets all applicants for the chair's session that the chair has not yet evaluated" do
      chair = create(:chair, camp: create(:camp, session: sessiona))
      applicant1.session_availabilities.create(session: sessiona)
      applicant2.session_availabilities.create(session: sessiona)
      applicant2.session_availabilities.create(session: sessionb)
      applicant3.session_availabilities.create(session: sessionb)
      chair.evaluations.create!(applicant: applicant1, rating: '9')
      expect(chair.unevaluated_applicants).to contain_exactly(applicant2)
    end
  end
end
