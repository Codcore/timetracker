class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :active_link

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    redirect_to login_path, alert: 'You should be logged in to access this page.' if current_user.nil?
  end

  def active_link(hash_params={})
    controller = hash_params.fetch(:controller, nil)
    action = hash_params.fetch(:action, nil)
    p controller_name
    p controller
    p action
    verify = []

    if controller
      controller_name == controller.to_s ? verify.push(true) : verify.push(false)
    end

    if action
      action_name == action.to_s ? verify.push(true) : verify.push(false)
    end

    p verify

    "active" if verify.all? { |item| item }
  end
end
