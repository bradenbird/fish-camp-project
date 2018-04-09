class FcController < ApplicationController

  #need this, otherwise submit will crash
  skip_before_action :verify_authenticity_token

  def index
    #do nothing yet
  end

  def home
    #default, load home
  end

  def register
    if !current_user then
      redirect_to login_path
    end
  end

  def profile
    if !current_user then
      redirect_to login_path
    end
  end

  def denied
    #do nothing yet
  end

  def interview
    if !current_user then
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

    validate = "SUBMITTED DATA:\nUIN: " + uin + "\nResponse 1: " + response1 + "\nResponse 2: " + response2 + "\n"
    print validate

    redirect_to applicants_path
  end

end