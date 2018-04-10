class InterviewsController < ApplicationController
	def new
		# all attributes are nil, so form shows up empty
		@applicant = current_user.chair.applicants.find(params[:applicant_id])
		@interview = Interview.new(applicant: @applicant)
	end

	def create
		# populates the object with the paramaters 
		@applicant = current_user.chair.applicants.find(interview_params[:applicant_id])
		@interview = current_user.chair.interviews.new(interview_params)
		if @interview.save 
			redirect_to "/fc/applicants"
		else
			Rails.logger.debug("errors: #{@interview.errors.inspect}")
			render "new"
		end
	end

	private

	def interview_params
		params.permit(interview: [:applicant_id, :transcript1, :transcript2])[:interview]
	end

end
