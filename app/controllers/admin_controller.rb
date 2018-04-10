class AdminController < ApplicationController
  def index 
    @users = User.all
    @applicants = Applicant.all
    if params[:search1]
      @users = User.search(params[:search1]).order("created_at DESC").limit(25)
      @applicants = Applicant.all.order("created_at DESC").limit(25)
    elsif params[:search2]
      @users = User.all.order("created_at DESC").limit(25)
      @applicants = Applicant.search(params[:search2]).order("created_at DESC").limit(25)
    else 
      @users = User.all.order("created_at DESC").limit(25)
      @applicants = Applicant.all.order("created_at DESC").limit(25)
    end
  end
end
