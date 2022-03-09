require "rails_helper"

RSpec.describe Session, type: :model do
  it "has a valid factory" do
    expect(create(:session)).to be_valid
  end

  it "is invalid without a name" do
    expect(build(:session, name: nil)).to_not be_valid
  end

  it "is invalid without a year" do
    expect(build(:session, year: nil)).to_not be_valid
  end

  it "is invalid without a start_date" do
    expect(build(:session, start_date: nil)).to_not be_valid
  end

  it "is invalid without an end_date" do
    expect(build(:session, end_date: nil)).to_not be_valid
  end

  it "is invalid unless end_date is after start_date" do
    session = build(:session)
    session.end_date = session.start_date - 2.days
    expect(session).to_not be_valid
  end

  describe "#all_session_names" do
    it "gets all of the names of the sessions" do
      sessiona = create(:session, name: "A")
      sessionb = create(:session, name: "B")
      sessionc = create(:session, name: "C")
      sessiond = create(:session, name: "D")
      expect(Session.all_session_names).to contain_exactly("A", "B", "C", "D")
    end
  end
end
