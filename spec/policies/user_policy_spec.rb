require "rails_helper"

describe UserPolicy do
  subject { described_class.new(user, user2) }

  let(:user2) { User.create }
  context "being a guest" do
    let(:user) { build(:user, role: "guest") }

    it { is_expected.to forbid_actions([:show, :edit, :index, :destroy]) }
  end

  context "being a chair" do
    let(:user) { build(:user, role: "chair") }

    it { is_expected.to forbid_actions([:show, :edit, :index, :destroy]) }
  end

  context "being an admin" do
    let(:user) { build(:user, role: "admin") }

    it { is_expected.to permit_actions([:show, :edit, :index, :destroy]) }
  end
end
