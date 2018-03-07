# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(create(:user)).to be_valid
  end
  it "is invalid without a google_uid" do
    expect(build(:user, google_uid: nil)).to_not be_valid
  end
  it "is invalid without a name" do
    expect(build(:user, name: nil)).to_not be_valid
  end
  it "is invalid without an email" do
    expect(build(:user, email: nil)).to_not be_valid
  end
  it "is invalid wihtout a role" do
    expect(build(:user, role: nil)).to_not be_valid
  end
end
