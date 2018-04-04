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

  def denied
    #do nothing yet
  end

  def interview
    #do nothing yet
  end

  def login
    requested_path = params[:reqpath]
    if current_user then
      if requested_path then
        if (requested_path == 'register') then
          redirect_to(register_path)
        elsif (requested_path == 'profile') then
          redirect_to(profile_path)
        else
          puts(requested_path)
        end
      else
        puts("Error")
      end
    end
  end

  def show
    redirect_to home_path
  end

end