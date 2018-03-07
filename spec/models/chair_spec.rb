require 'rails_helper'

RSpec.describe Chair, type: :model do
  it "has a valid factory" do
    expect(create(:chair)).to be_valid
  end
  it "is invalid without a camp" do
    expect(build(:chair, camp: nil)).to_not be_valid
  end
  it "is invalid without a user" do
    expect(build(:chair, user: nil)).to_not be_valid
  end
end
