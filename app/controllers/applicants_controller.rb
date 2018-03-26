class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def import
    authorize Applicant, :create?
    extension = File.extname(params[:file].original_filename)
    Applicant.import(params[:file].path, extension)
    redirect_to request.referrer, notice: "Applicants imported."
  end
end
