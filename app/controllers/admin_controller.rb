class AdminController < ApplicationController
  def index
    authorize Applicant, :index?
    authorize User, :index?

    @title = "Admin Console"

    if params[:commit].present?
      user = User.find(params[:user_id])
      user.create_chair(params[:session_id], params[:color])
      redirect_to makeChair_users_path(id: user.id), method: :get
    end
    @users = User.all
    @applicants = Applicant.all
    @users = if params[:search1]
      User.search(params[:search1]).order("created_at DESC")
    else
      User.all.order("created_at DESC")
    end

    @applicants = if params[:search2]
      Applicant.search(params[:search2]).order("created_at DESC")
    else
      Applicant.all.order("created_at DESC")
    end
    @applicants = @applicants.paginate(page: params[:page], per_page: 20)
  end

  def show
    authorize User, :index?

    @title = "User Update Page"

    id = params[:id]
    @user = User.find(id)
  end
end
