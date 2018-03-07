require 'rails_helper'

RSpec.describe SessionAvailability, type: :model do
  it "has a valid factory" do
    expect(create(:session_availability)).to be_valid
  end
  it "is invalid without an applicant" do
    expect(build(:session_availability, applicant: nil)).to_not be_valid
  end
  it "is invalid without a session" do
    expect(build(:session_availability, session: nil)).to_not be_valid
  end
end
