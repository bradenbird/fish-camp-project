class AdminController < ApplicationController
  def index 
    if params[:commit].present?
      user = User.find(params[:user_id])
      user.create_chair(params[:session_id], params[:color])
      redirect_to makeChair_users_path(:id => user.id ), :method => :get
    end
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
    authorize User, :index?
    id = params[:id]
    @user = User.find(id)
  end
end
