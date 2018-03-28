class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
    
    if params[:sessions].present?
      @current_sessions = params[:sessions].keys
      @applicants = Applicant.joins(:sessions).where(sessions: {name: @current_sessions}).distinct
    else
      @current_sessions = Session.all_session_names 
    end

    if params[:evaluated].present?
      @show_evaluated = true
      #Set applicants to show all
    else
      @show_evaluated = false
      #Set applicants to show unevaluated
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
