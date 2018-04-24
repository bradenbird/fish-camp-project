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

  describe "#create_chair" do
    # let(:sessiona) {  }
    it "creates a chair linked to a camp" do
      sessiona = create(:session, name: "A", id: 1)
      camp1 = create(:camp, name: "red", session: sessiona)
      user = create(:user)
      expect(user.create_chair(1, "red")).to be_valid
    end
    it "deletes old chair records for the same user" do
      sessiona = create(:session, name: "A", id: 1)
      camp1 = create(:camp, name: "red", session: sessiona)
      camp2 = create(:camp, name: "blue", session: sessiona)
      user = create(:user)
      user.create_chair(1, "red")
      user.create_chair(1, "blue")
      expect(Chair.all.count).to eq(1)
      expect(Chair.first.camp.name).to eq("blue")
    end
  end

end
