class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
    if params[:sessions].present?
      @current_sessions = params[:sessions].keys
    end
  end

  def import
    authorize Applicant, :create?
    if params[:file].nil? 
      raise IOError, "Please Choose a file"
    else 
      extension = File.extname(params[:file].original_filename)
      Applicant.import(params[:file].path, extension)
      redirect_to request.referrer, notice: "Applicants imported."
    end 
  end
end
