class UsersController < ApplicationController

  find :user

  before_action :authenticate_admin!, except: [:new, :create]
  before_action :find_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.paginate(page: params[:page], per_page: 20)
  end

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

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "User was successfully updated"
      redirect_to users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :surname, :date_of_birth, :position, :admin, :email, :password, :password_confirmation)
    end
end
