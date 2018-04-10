class FcController < ApplicationController

  #need this, otherwise submit will crash
  skip_before_action :verify_authenticity_token

  #internal function, returns true if the current_user
  #is valid, and if they have at least the clearance level
  #required by the calling function
  def check_user(current_user, clearance_level)
    if current_user == nil then
      return false
    end
    if clearance_level == "admin" then
      return current_user.role == "admin"
    end
    if clearance_level == "chair" then
      return (current_user.role == "admin" || current_user.role == "chair")
    end
  end

  def index
    #do nothing yet
  end

  def home
    #default, load home
  end

  def register
    if !check_user(current_user, "chair") then
      redirect_to login_path
    end
  end

  def profile
    if !check_user(current_user, "chair") then
      redirect_to login_path
    end
  end

  def denied
    #do nothing yet
  end

  def interview
    if !check_user(current_user, "chair") then
      redirect_to login_path
    end

    @curr_applicant = params[:id]
  end

  def login
    #do nothing yet
  end

  def show
    redirect_to home_path
  end

  def submit
    uin = params[:value].to_s.scan(/\d/).join('')
    response1 = params[:question1]
    response2 = params[:question2]
    interviewer = current_user.name

    validate = "SUBMITTED DATA:\nUIN: " + uin + "\nResponse 1: " + response1 + "\nResponse 2: " + response2 + "\nInterviewer: " + interviewer + "\n"
    print validate

    redirect_to applicants_path
  end

end