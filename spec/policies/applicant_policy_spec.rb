require 'rails_helper'

describe ApplicantPolicy do
  subject { described_class.new(user, applicant)}

  let(:applicant) {Applicant.create}
  context 'being a guest' do
      let (:user) {build(:user, role: "guest")}

      it { is_expected.to forbid_actions([:create, :show, :index, :destroy]) }
  end

  context 'being a chair' do
    let (:user) {build(:user, role: "chair")}

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions([:create, :index, :destroy]) }
  end

  context 'being an admin' do
    let (:user) {build(:user, role: "admin")}

    it { is_expected.to permit_actions([:create, :show, :index, :destroy]) }
  end

end
