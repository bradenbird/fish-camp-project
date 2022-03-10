require "rails_helper"

RSpec.describe Applicant, type: :model do
  it "has a valid factory" do
    expect(create(:applicant)).to be_valid
  end

  it "is invalid without a submission_id" do
    expect(build(:applicant, submission_id: nil)).to_not be_valid
  end

  it "is invalid without a uin" do
    expect(build(:applicant, uin: nil)).to_not be_valid
  end

  describe ".import" do
    before do
      ("A".."G").each { |letter| create(:session, name: letter) }
      file_path = "#{Rails.root}/spec/fixtures/fc_sample.csv"
      Applicant.import(file_path, ".csv")
    end

    let(:applicant_1) { Applicant.find_by(submission_id: 12255241) }
    let(:applicant_2) { Applicant.find_by(submission_id: 12389115) }

    it "imports first names properly" do
      expect(applicant_1.first_name).to eq("Brooke")
      expect(applicant_2.first_name).to eq("Corey")
    end

    it "imports last names properly" do
      expect(applicant_1.last_name).to eq("Aaron")
      expect(applicant_2.last_name).to eq("Able")
    end

    it "creates the proper session_availabilities" do
      session_names1 = applicant_1.sessions.map { |s| s.name }
      session_names2 = applicant_2.sessions.map { |s| s.name }
      expect(session_names1).to contain_exactly("A", "B", "C", "D", "E", "F", "G")
      expect(session_names2).to contain_exactly("B", "C", "D", "E", "F", "G")
    end
  end

  describe "#all_session_names" do
    it "gets all of the names of sessions that have applicants" do
      applicant_1 = create(:applicant)
      applicant_2 = create(:applicant)
      session_a = create(:session, name: "A")
      session_b = create(:session, name: "B")
      session_c = create(:session, name: "C")
      session_e = create(:session, name: "E")

      applicant_1.session_availabilities.create!(session: session_a)
      applicant_1.session_availabilities.create!(session: session_b)
      applicant_1.session_availabilities.create!(session: session_c)
      applicant_2.session_availabilities.create!(session: session_a)
      applicant_2.session_availabilities.create!(session: session_e)
      expect(Applicant.all_session_names).to contain_exactly("A", "B", "C", "E")
    end
  end

  describe "#has_interviews?" do
    context "with interviews" do
      let(:applicant) { create(:applicant, :with_interviews) }

      it "should return true with an interview" do
        expect(applicant.has_interviews?).to be true
      end
    end

    context "without interviews" do
      let(:applicant) { create(:applicant) }

      it "should return true with an interview" do
        expect(applicant.has_interviews?).to be false
      end
    end
  end
end
