class EvaluationsController < ApplicationController
  def create
    @applicant = Applicant.find(evaluation_params[:applicant_id])
    @evaluation = current_user.chair.evaluations.new(evaluation_params)
    if @evaluation.save
      redirect_to "/fc/applicants"
    else
      Rails.logger.debug("errors: #{@evaluation.errors.inspect}")
      render "new"
    end
  end

  private 

  def evaluation_params
    params.permit(evaluation: [:applicant_id, :rating])[:evaluation]
  end
end