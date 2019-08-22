require_relative '../../helpers/messages/projects_messages'

module Admin
  class ProjectsController < AdminController

    include Messages::ProjectsMessages

    before_action :find_project, only: %w(show destroy edit update assign_user unassign_user)
    before_action :find_user, only: %w(assign_user unassign_user)

    def index
      # TODO: make a pagination
      @projects = Project.all.includes(:author).paginate(page: params[:page], per_page: 10)
    end

    def show
      @users_array = User.programmers.where.not(id: @project.users.pluck(:id))
          .map { |user| ["#{user.name} #{user.surname}", user.id] }
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      @project.user_id = current_user.id

      if @project.save
        flash[:notice] = MSG_PROJECT_CREATED
        redirect_to admin_project_path(@project)
      else
        render :new
      end
    end

    def edit; end

    def update
      if @project.update(project_params)
        flash[:notice] = MSG_PROJECT_UPDATED
        redirect_to admin_project_path(@project)
      else
        render :edit
      end
    end

    def destroy
      @project.destroy
      redirect_to admin_projects_path
    end

    def assign_user
      @project.users << @user
      flash[:notice] = MSG_USER_ASSIGNED
      redirect_to admin_project_path(@project)
    end

    def unassign_user
      @project.users.delete(@user)
      flash[:notice] = MSG_USER_UNASSIGNED
      redirect_to admin_project_path(@project)
    end

    private

      def find_project
        @project = Project.find_by(slug: params[:slug])
      end

      def find_user
        @user = User.find(params[:assign_user])
      end

      def project_params
        params.require(:project).permit(:name, :description)
      end
  end
end
