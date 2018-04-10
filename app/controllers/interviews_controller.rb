class InterviewsController < ApplicationController
	def new
		# all attributes are nil, so form shows up empty
		@interview = Interview.new
	end

	def create
		# populates the object with the paramaters 
		@interview = Interview.new(params[:interview])
		if @interview.save 
			redirect_to @interview
		else
			render "new"
		end
	end
end
