class FcController < ApplicationController

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
    #do nothing yet
  end

  def login
    #do nothing yet
  end

  def show
    redirect_to home_path
  end

end