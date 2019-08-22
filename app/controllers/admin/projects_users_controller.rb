require_relative '../../helpers/messages/projects_users_messages'

module Admin
  class ProjectsUsersController < AdminController

    include Messages::ProjectsUsersMessages

    before_action :find_project, only: %w(create destroy index)
    before_action :find_user, only: %w(destroy create)

    def index
      @users_array = User.programmers.where.not(id: @project.users.pluck(:id)).map { |user| ["#{user.name} #{user.surname}", user.id] }
    end

    def create
      @project.users << @user
      flash[:notice] = MSG_USER_ASSIGNED
      redirect_to admin_project_projects_users_path(@project)
    end

    def destroy
      @project.users.delete(@user)
      flash[:notice] = MSG_USER_UNASSIGNED
      redirect_to admin_project_projects_users_path(@project)
    end

    private

    def find_project
      @project = Project.find_by(slug: params[:project_slug])
    end

    def find_user
      @user = User.find(params.permit(:user_id)[:user_id])
    end
  end
end
