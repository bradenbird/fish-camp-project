class AdminController < ApplicationController
  def index 
    @users = User.all
    @applicant = Applicant.all
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC").limit(25)
    else 
      @users = User.all.order("created_at DESC").limit(25)
    end
  end
end
