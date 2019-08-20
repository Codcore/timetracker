class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id.to_s
      if @user.admin?
        redirect_to admin_projects_path, notice: "Welcome, administrator #{@user.name} #{@user.surname}!"
      else
        redirect_to root_path, notice: "Welcome, #{@user.name} #{@user.surname}!"
      end
    else
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: 'Logged out successfully.'
  end
end
