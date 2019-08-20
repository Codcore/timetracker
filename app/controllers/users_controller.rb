class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.email.downcase!

    if @user.save
      flash[:notice] = "Account successfully created."
      redirect_to root_path
    else
      flash.now[:alert] = "Please, fill in all required fields."
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
    end
end
