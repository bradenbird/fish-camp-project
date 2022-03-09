include Pundit

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from IOError do |exception|
    flash[:error] = exception.message
    redirect_to(request.referrer || root_path)
  end

  private

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def invalid_arguments
    flash[:error] = "Improper Arguments for Operation"
    redirect_to(request.referrer || root_path)
  end
end
