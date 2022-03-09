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
    # testing for import goes here
    # it "has a valid fixture" do
    #   expect(build(:applicant.import, file: "../fixtures/fc_sample.csv")).to be_valid
    # end
    before do
      ("A".."G").each { |letter| create(:session, name: letter) }
      file_path = "#{Rails.root}/spec/fixtures/fc_sample.csv"
      Applicant.import(file_path, ".csv")
    end
    let(:applicant1) { Applicant.find_by(submission_id: 12255241) }
    let(:applicant2) { Applicant.find_by(submission_id: 12389115) }
    it "imports first names properly" do
      expect(applicant1.first_name).to eq("Brooke")
      expect(applicant2.first_name).to eq("Corey")
    end
    it "imports last names properly" do
      expect(applicant1.last_name).to eq("Aaron")
      expect(applicant2.last_name).to eq("Able")
    end
    it "creates the proper session_availabilities" do
      session_names1 = applicant1.sessions.map { |s| s.name }
      session_names2 = applicant2.sessions.map { |s| s.name }
      expect(session_names1).to contain_exactly("A", "B", "C", "D", "E", "F", "G")
      expect(session_names2).to contain_exactly("B", "C", "D", "E", "F", "G")
    end
  end

  describe "#all_session_names" do
    it "gets all of the names of sessions that have applicants" do
      applicant1 = create(:applicant)
      applicant2 = create(:applicant)
      sessiona = create(:session, name: "A")
      sessionb = create(:session, name: "B")
      sessionc = create(:session, name: "C")
      sessione = create(:session, name: "E")

      applicant1.session_availabilities.create!(session: sessiona)
      applicant1.session_availabilities.create!(session: sessionb)
      applicant1.session_availabilities.create!(session: sessionc)
      applicant2.session_availabilities.create!(session: sessiona)
      applicant2.session_availabilities.create!(session: sessione)
      expect(Applicant.all_session_names).to contain_exactly("A", "B", "C", "E")
    end
  end

  describe ".has_interviews?" do
    let(:applicant) { create(:applicant) }

    it "should return true with an interview" do
      expect(applicant.has_interviews?).to be true
    end
  end
end
