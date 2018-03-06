class ApplicantsController < ApplicationController
    def index
      @applicants = Applicant.order(:first_name)
    end 
    
    def import 
      Applicant.import(params[:file])
      redirect_to root_url, notice: "Applicants imported."  
    end
end 