class ApplicantsController < ApplicationController
  def index 
    @applicants = Applicant.all
  end 
    
  def import 
    Applicant.import(params[:file])
    redirect_to request.referrer, notice: "Applicants imported."  
  end
end
