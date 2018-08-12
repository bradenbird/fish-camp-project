require 'rails_helper'

RSpec.describe Interview, type: :model do
	it "has a valid factory" do
    expect(create(:session_availability)).to be_valid
    expect(create(:session_availability).new_record?).to be_falsey
  end

  it "is invalid without a chair" do
  	expect(build(:interview, chair: nil)).to_not be_valid
    expect(build(:interview).new_record?).to be_truthy
  end

  it "is invalid without an applicant" do
  	expect(build(:interview, applicant: nil)).to_not be_valid
  end
end
