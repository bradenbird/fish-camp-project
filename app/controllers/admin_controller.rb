class AdminController < ApplicationController
  def index 
    authorize Applicant, :index?
    authorize User, :index?
    @users = User.all
    @applicants = Applicant.all
    if params[:search1]
      @users = User.search(params[:search1]).order("created_at DESC").limit(50)
      @applicants = Applicant.all.order("created_at DESC").limit(50)
      
    elsif params[:search2]
      @users = User.all.order("created_at DESC").limit(50)
      @applicants = Applicant.search(params[:search2]).order("created_at DESC").limit(50)
      
    elsif params[:search1] && params[:search2]
      @users = User.search(params[:search1]).order("created_at DESC").limit(50)
      @applicants = Applicant.search(params[:search2]).order("created_at DESC").limit(50)
    
    else 
      @users = User.all.order("created_at DESC").limit(50)
      @applicants = Applicant.all.order("created_at DESC").limit(50)
    end
  end
end
