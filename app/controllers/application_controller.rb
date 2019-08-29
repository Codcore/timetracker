class ApplicationController < ActionController::Base

  include ApplicationHelper

  protect_from_forgery with: :exception

  helper_method :current_user, :user_admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to login_path, alert: 'You should be logged in to access this page.' if current_user.nil?
  end

  def authenticate_admin!
    redirect_to root_path, alert: "You\'re not authorized to access this page" unless current_user.admin?
  end

  def user_admin?
    current_user.admin?
  end
end
