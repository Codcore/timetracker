class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :active_link

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to login_path, alert: 'You should be logged in to access this page.' if current_user.nil?
  end

  def active_link(item)
    controller = controller_name.to_sym
    "active" if controller == item.to_sym
  end
end
