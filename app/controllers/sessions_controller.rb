class SessionsController < ApplicationController

  before_action :authenticate_user!, only: :destroy

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id.to_s
      redirect_to root_path, notice: "Welcome, #{@user.name} #{@user.surname}!"
    else
      flash[:error] = "Wrong email and password combination"
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: 'Logged out successfully.'
  end
end
