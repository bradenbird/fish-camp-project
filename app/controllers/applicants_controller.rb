class ApplicantsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    authorize Applicant, :show?

    @title = "Applicant Database"

    if params[:commit].present? && params[:commit] == "Find"
      uin = params[:find][:uin]
      if Applicant.exists?(uin: uin)
        redirect_to applicant_path(uin)
      elsif !Applicant.exists?(uin: uin)
        flash[:error] = "UIN not found in database"
        redirect_to applicants_path
      end
    end

    # Change to only chairs since to use it you should be a chair
    if current_user.chair?
      if params[:unevaluated].present?
        #Set applicants to show only unevaluated applicants
        @show_unevaluated = true
        @applicants = current_user.chair.unevaluated_applicants
      else
        #Set applicants to show all
        @show_unevaluated = false
        @applicants = current_user.chair.applicants
      end
    else
      @applicants = Applicant.all
    end

    # Maybe change to admin only filters? Chairs only need to see people for their session
    if current_user.admin?
      if params[:sessions].present?
        @current_sessions = params[:sessions].keys
        @applicants = @applicants.includes(:sessions).where(sessions: {name: @current_sessions}).preload(:evaluations).distinct
      else
        @current_sessions = Session.all_session_names
        @applicants = @applicants.all.preload(:evaluations, :sessions)
      end
    end

    if params[:classifications].present?
      @current_classifications = params[:classifications].keys
      @applicants = @applicants.where(classification: @current_classifications)
    else
      @current_classifications = ['Freshmen', 'Sophomore', 'Junior', 'Senior', 'Graduate']
    end

    if params[:show].present?
      #@even_applicants, @odd_applicants = @applicants.partition{ |r| r.id.even? }
      @odd = false
      @even = false
      @all = false
      if params[:show] == "odd"
        @applicants = @applicants.where('applicants.id % 2 = 1')
        @odd = true
      elsif params[:show] == "even"
        @applicants = @applicants.where('applicants.id % 2 = 0')
        @even = true
      else
        @all = true
      end
    else
      @all = true
    end

    if params[:gender].present?
      #@male_applicants, @female_applicants = @applicants.partition{ |r| r.gender == "Male" }
      @male = false
      @female = false
      @both = false
      if params[:gender] == "Male"
        @applicants = @applicants.where(gender: 'Male')
        @male = true
      elsif params[:gender] == "Female"
        @applicants = @applicants.where(gender: 'Female')
        @female = true
      else
        @both = true
      end
    else
      @both = true
    end
    @applicants = @applicants.paginate(page: params[:page], per_page: 20)
  end

  def edit
    authorize Applicant, :create?
    @title = "Applicant Update Page"
    @applicant = Applicant.find_by(uin: params[:id])
  end

  def update
    authorize Applicant, :create?
    @title = "Applicant Update Page"
    @applicant = Applicant.find_by(uin: params[:id])
    params.permit!
    @applicant.update_attributes(applicant_params)

    # Some more complicated logic that can't be handled by update_attributes
    @applicant.session_availabilities.destroy_all
    params[:sessions].each do |session|
      curr_sess = Session.find_by(name: session)
      @applicant.session_availabilities.create!(session: curr_sess)
    end
    @applicant.dietary_none = !@applicant.dietary_red_meat && !@applicant.dietary_vegan && !@applicant.dietary_vegetarian && !@applicant.dietary_dairy_free && !@applicant.dietary_gluten_free && @applicant.dietary_other.blank?
    @applicant.accommodations_none = !@applicant.accommodations_auditory && !@applicant.accommodations_visual && !@applicant.accommodations_physical && @applicant.accommodations_other.blank?
    @applicant.save!
    flash[:notice] = "You have updated the application"
    redirect_to applicant_path(@applicant)
  end

  def show
    authorize Applicant, :show?
    @title = "Applicant"
    @applicant = Applicant.find_by(uin: params[:id])
    @evaluation = Evaluation.new(applicant: @applicant)
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

  def delete_all
    authorize Applicant, :destroy?
    Applicant.all.each do |app|
      app.destroy
    end
    Applicant.delete_all
    flash[:notice] = "You have removed all applicants"
    redirect_to request.referrer
  end

  def destroy
    authorize Applicant, :destroy?
    @applicant = Applicant.find_by(uin: params[:id])
    @applicant.session_availabilities.destroy_all
    @applicant.destroy
    flash[:notice] = "You have removed the applicant"
    redirect_to request.referrer
  end

  private

  def applicant_params
    params.require(:applicant)
  end

end
