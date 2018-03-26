class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end 

  def import
    authorize Applicant, :create?
    Applicant.import(params[:file])
    redirect_to request.referrer, notice: "Applicants imported."
  end
end
