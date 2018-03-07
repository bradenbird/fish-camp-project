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

  describe "import" do
    # testing for import goes here
    it "has a valid fixture" do
      expect(build(:applicant.import, file: "../fixtures/fc_sample.csv")).to be_valid
    end
  end
end
