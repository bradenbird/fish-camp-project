require 'spec_helper'

RSpec.describe Camp, type: :model do
  it "has a valid factory" do
    expect(create(:camp)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:camp, name: nil)).to_not be_valid
  end

  it "is invalid without an associated session" do
    expect(build(:camp, session: nil)).to_not be_valid
  end
end
