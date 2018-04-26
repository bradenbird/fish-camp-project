require 'will_paginate/array'

class ApplicantsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def index
    authorize Applicant, :show?
    if params[:commit].present? && params[:commit] == "Find"
      uin = params[:find][:uin]
      if Applicant.exists?(uin: uin)
        redirect_to applicants_path + "/#{uin}"
      end
      flash[:error] = "UIN not found in database"
    end
    # @applicants = Applicant.paginate(:page => params[:page], :per_page => 20)
    @applicants = Applicant.all.preload(:evaluations, :sessions)

    # Maybe change to admin only filters? Chairs only need to see people for their session
    if params[:sessions].present?
      @current_sessions = params[:sessions].keys
      @applicants = Applicant.includes(:sessions).where(sessions: {name: @current_sessions}).preload(:evaluations).distinct
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
    @applicants = @applicants.paginate(page: params[:page], per_page: 20)
  end
  
  def edit 
    authorize Applicant, :create?
    uin = params[:uin]
    @applicant = Applicant.all.find_by 'uin = ?', uin
  end
  
  def update
    authorize Applicant, :create?
    uin = params[:uin]
    @applicant = Applicant.all.find_by 'uin = ?', uin
    @applicant.first_name = params['applicant'][:first_name]
    @applicant.last_name = params['applicant'][:last_name]
    @applicant.uin = params['applicant'][:uin]
    @applicant.gender = params['applicant'][:gender]
    @applicant.tamu_email = params['applicant'][:tamu_email]
    @applicant.other_email = params['applicant'][:other_email]
    @applicant.phone = params['applicant'][:phone]
    #FC Info
    @applicant.session_availabilities.destroy_all
    params[:sessions].each do |session|
      curr_sess = Session.find_by(name: session)
      @applicant.session_availabilities.create!(session: curr_sess)
    end
    @applicant.camp_counselor = params['applicant'][:camp_counselor]
    @applicant.crew_counselor = params['applicant'][:crew_counselor]
    @applicant.pick_up_only = params['applicant'][:pick_up_only]
    @applicant.camp_history = params['applicant'][:camp_history]
    @applicant.no_show_explanation = params['applicant'][:no_show_explanation]
    #Parent Info
    @applicant.parent_name = params['applicant'][:parent_name]
    @applicant.parent_email = params['applicant'][:parent_email]
    @applicant.parent_address = params['applicant'][:parent_address]
    @applicant.parent_city = params['applicant'][:parent_city]
    @applicant.parent_state = params['applicant'][:parent_state]
    @applicant.parent_zip = params['applicant'][:parent_zip]
    #Alternate Contact 1 Info
    @applicant.alt_contact_1_name = params['applicant'][:alt_contact_1_name]
    @applicant.alt_contact_1_email = params['applicant'][:alt_contact_1_email]
    @applicant.alt_contact_1_address = params['applicant'][:alt_contact_1_address]
    @applicant.alt_contact_1_city = params['applicant'][:alt_contact_1_city]
    @applicant.alt_contact_1_state = params['applicant'][:alt_contact_1_state]
    @applicant.alt_contact_1_zip = params['applicant'][:alt_contact_1_zip]
    #Alternate Contact 2 Info
    @applicant.alt_contact_2_name = params['applicant'][:alt_contact_2_name]
    @applicant.alt_contact_2_email = params['applicant'][:alt_contact_2_email]
    @applicant.alt_contact_2_address = params['applicant'][:alt_contact_2_address]
    @applicant.alt_contact_2_city = params['applicant'][:alt_contact_2_city]
    @applicant.alt_contact_2_state = params['applicant'][:alt_contact_2_state]
    @applicant.alt_contact_2_zip = params['applicant'][:alt_contact_2_zip]
    #Insurance Info
    @applicant.insurance_provider = params['applicant'][:insurance_provider]
    @applicant.insurance_policy_number = params['applicant'][:insurance_policy_number]
    @applicant.insurance_policy_holder_name = params['applicant'][:insurance_policy_holder_name]
    #Health Info
    @applicant.last_tetanus_booster_date = params['applicant'][:last_tetanus_booster_date]
    @applicant.drug_allergies = params['applicant'][:drug_allergies]
    @applicant.food_allergies = params['applicant'][:food_allergies]
    @applicant.dietary_red_meat = params['applicant'][:dietary_red_meat]
    @applicant.dietary_vegan = params['applicant'][:dietary_vegan]
    @applicant.dietary_vegetarian = params['applicant'][:dietary_vegetarian]
    @applicant.dietary_dairy_free = params['applicant'][:dietary_dairy_free]
    @applicant.dietary_gluten_free = params['applicant'][:dietary_gluten_free]
    @applicant.dietary_other = params['applicant'][:dietary_other]
    @applicant.dietary_none = !@applicant.dietary_red_meat && !@applicant.dietary_vegan && !@applicant.dietary_vegetarian && !@applicant.dietary_dairy_free && !@applicant.dietary_gluten_free && @applicant.dietary_other.blank?
    @applicant.medications = params['applicant'][:medications]
    @applicant.accommodations_auditory = params['applicant'][:accommodations_auditory]
    @applicant.accommodations_visual = params['applicant'][:accommodations_visual]
    @applicant.accommodations_physical = params['applicant'][:accommodations_physical]
    @applicant.accommodations_other = params['applicant'][:accommodations_other]
    @applicant.accommodations_none = !@applicant.accommodations_auditory && !@applicant.accommodations_visual && !@applicant.accommodations_physical && @applicant.accommodations_other.blank?
    @applicant.other_medical_concerns = params['applicant'][:other_medical_concerns]
    @applicant.save!
    flash[:notice] = "You have updated the application"
    redirect_to "/applicants/edit?uin=#{@applicant.uin}"
  end

  def show
    authorize Applicant, :show?
    uin = params[:uin]
    @applicant = Applicant.all.find_by 'uin = ?', uin
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
      app.session_availabilities.destroy_all
    end
    Applicant.delete_all
    flash[:notice] = "You have removed all applicants"
    redirect_to request.referrer
  end
  
  def destroy 
    authorize Applicant, :destroy?
    @applicant = Applicant.find(params[:id])
    @applicant.session_availabilities.destroy_all
    @applicant.destroy
    flash[:notice] = "You have removed the applicant"
    redirect_to request.referrer
  end

end
