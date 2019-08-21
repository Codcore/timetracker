class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email.downcase!

    if @user.save
      flash[:notice] = "Account successfully created. Now you can log in."
      redirect_to login_path
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
    end
end
