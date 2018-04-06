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

    @even_applicants, @odd_applicants = @applicants.partition{ |r| r.id.even? }
    if params[:show].present?
      @odd = false
      @even = false
      @all = false
      if params[:show] == "odd"
        @applicants = @odd_applicants
        @odd = true

      elsif params[:show] == "even"
        @applicants = @even_applicants
        @even = true
      else
        @all = true
      end
    else
      @all = true
    end

  end

  def show
    uin = params[:uin]
    @applicant = Applicant.all.find_by 'uin = ?', uin
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
