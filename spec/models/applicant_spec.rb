require 'rails_helper'

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
      ("A".."G").each{ |letter| create(:session, name: letter) }
      file_path = "#{Rails.root}/spec/fixtures/fc_sample.csv"
      Applicant.import(file_path, ".csv")
    end
    it "imports first names properly" do
      # byebug
      expect(Applicant.find_by(submission_id: 12255241).first_name).to eq("Brooke")
    end
    it "imports last names properly" do
      expect(Applicant.find_by(submission_id: 12255241).last_name).to eq("Aaron")
    end
  end
end
