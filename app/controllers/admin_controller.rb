class AdminController < ApplicationController
  def index 
    authorize Applicant, :index?
    authorize User, :index?
    @users = User.all
    @applicants = Applicant.all
    if params[:search1]
      @users = User.search(params[:search1]).order("created_at DESC").limit(50)
    else 
      @users = User.all.order("created_at DESC").limit(50)
    end
    
    if params[:search2]
      @applicants = Applicant.search(params[:search2]).order("created_at DESC").limit(50)
    else 
      @applicants = Applicant.all.order("created_at DESC").limit(50)
    end
  end

  def show
    if !current_user then
      redirect_to login_path
    end

    id = params[:id]
    @user = User.find(id)
  end
end
