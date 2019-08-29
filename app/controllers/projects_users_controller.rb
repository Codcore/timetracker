class ProjectsUsersController < ApplicationController

  MSG_USER_ASSIGNED   = "User was successfully assigned to the project"
  MSG_USER_UNASSIGNED = "User was successfully unassigned"

  find :project, :slug
  find :user

  before_action :find_project, only: %i(create destroy index)
  before_action :find_user, only: %i(destroy create)

  before_action :authenticate_user!
  before_action :authenticate_admin!, only: %i(create destroy)

  def index
    @users_array = User.programmers.where
                       .not(id: @project.users.pluck(:id))
                       .map { |user| ["#{user.name} #{user.surname}", user.id] }
  end

  def create
    @project.users << @user
    flash[:notice] = MSG_USER_ASSIGNED
    redirect_to project_projects_users_path(@project)
  end

  def destroy
    @project.users.delete(@user)
    flash[:notice] = MSG_USER_UNASSIGNED
    redirect_to project_projects_users_path(@project)
  end
end
