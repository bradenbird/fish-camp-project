class ApplicantsController < ApplicationController
    def index
      @applicants = Applicant.order(:first_name)
    end 
    
    def import 
      Applicant.import(params[:file])
      redirect_to request.referrer, notice: "Applicants imported."  
    end
end 