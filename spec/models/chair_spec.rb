require "rails_helper"

RSpec.describe Chair, type: :model do
  let(:session_a) { create(:session, name: "A") }
  let(:session_b) { create(:session, name: "B") }
  let(:applicant_1) { create(:applicant) }
  let(:applicant_2) { create(:applicant) }
  let(:applicant_3) { create(:applicant) }

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
      chair = create(:chair, camp: create(:camp, session: session_a))
      applicant_1.session_availabilities.create(session: session_a)
      applicant_2.session_availabilities.create(session: session_a)
      applicant_2.session_availabilities.create(session: session_b)
      applicant_3.session_availabilities.create(session: session_b)
      expect(chair.applicants).to contain_exactly(applicant_1, applicant_2)
    end
  end

  describe "#unevaluated_applicants" do
    it "gets all applicants for the chair's session that the chair has not yet evaluated" do
      chair = create(:chair, camp: create(:camp, session: session_a))
      applicant_1.session_availabilities.create(session: session_a)
      applicant_2.session_availabilities.create(session: session_a)
      applicant_2.session_availabilities.create(session: session_b)
      applicant_3.session_availabilities.create(session: session_b)
      chair.evaluations.create!(applicant: applicant_1, rating: "9")
      expect(chair.unevaluated_applicants).to contain_exactly(applicant_2)
    end
  end
end
