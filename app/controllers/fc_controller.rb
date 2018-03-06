class FcController < ApplicationController

  def index
    #do nothing yet
  end

  def home
    #default, load home
  end

  def register
    #do nothing yet
  end

  def profile
    #do nothing yet
  end

  def login
    requested_path = params[:reqpath]
    if current_user then
      if requested_path then
        redirect_to(requested_path)
      else
        puts("Error")
      end
    end
  end

  def show
    redirect_to home_path
  end

end