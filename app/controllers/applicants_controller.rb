class ApplicantsController < ApplicationController
  def index
    if !current_user then
      redirect_to login_path
    end
    if params[:commit].present? && params[:commit] == "Find"
      uin = params[:find][:uin]
      if Applicant.exists?(uin: uin)
        redirect_to applicants_path + "/#{uin}"
      end
      flash[:error] = "UIN not found in database"
    end
    @applicants = Applicant.all

    # Maybe change to admin only filters? Chairs only need to see people for their session
    if params[:sessions].present?
      @current_sessions = params[:sessions].keys
      @applicants = Applicant.joins(:sessions).where(sessions: {name: @current_sessions}).distinct
    else
      @current_sessions = Session.all_session_names
    end

    if params[:classifications].present?
      @current_classifications = params[:classifications].keys
      @applicants = @applicants.where(classification: @current_classifications)
    else
      @current_classifications = ['Freshmen', 'Sophomore', 'Junior', 'Senior', 'Graduate']
    end

    # Change to only chairs since to use it you should be a chair
    if params[:evaluated].present?
      @show_evaluated = true
      #Set applicants to show all
    else
      @show_evaluated = false
      #Set applicants to show unevaluated
    end

    if params[:show].present?
      @even_applicants, @odd_applicants = @applicants.partition{ |r| r.id.even? }
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

    if params[:gender].present?
      @male_applicants, @female_applicants = @applicants.partition{ |r| r.gender == "Male" }
      @male = false
      @female = false
      @both = false
      if params[:gender] == "Male"
        @applicants = @male_applicants
        @male = true
      elsif params[:gender] == "Female"
        @applicants = @female_applicants
        @female = true
      else
        @both = true
      end
    else
      @both = true
    end

  end

  def show
    if !current_user then
      redirect_to login_path
    end

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
  
  def delete_all
    Applicant.delete_all
    #Session.delete_all
    flash[:notice] = "You have removed all applicants"
    redirect_to request.referrer
  end
  
  def destroy 
    @applicant = Applicant.find(params[:id])
    #uin = @applicant.uin
    #@session = Session.find_by 'uin = ?', uin
    @applicant.destroy
   # @session.destroy
    flash[:notice] = "You have removed the applicant"
    redirect_to request.referrer
  end
end
