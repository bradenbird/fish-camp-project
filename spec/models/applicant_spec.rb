require 'rails_helper'

RSpec.describe Applicant, type: :model do
  it "has a valid factory" do
    Factory.create(:applicant).should be_valid
  end
  it "is invalid without a submission_id"
  it "is invalid without a uin"
end
