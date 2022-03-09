require "rails_helper"

RSpec.describe ApplicantsController, type: :controller do
  describe "GET #index" do
    subject { get :index }

    it "renders the index view" do
      expect(subject).to render_template(:index)
    end
  end

  # describe "GET #destroy" do
  # 	it "deletes the applicant" do
  # 		applicant = create(:applicant)
  # 		params = Hash.new
  # 		params[:id] = applicant.id
  # 		Applicant.destroy
  # 		expect(Applicant.all.count).to eq(0)
  # 	end
  # end
end
