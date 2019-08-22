module Admin
  class ProjectsController < AdminController

    before_action :find_project, only: [:show, :destroy, :edit, :update, :assign_user, :unassign_user]

    def index
      # TODO: make a pagination
      @projects = Project.all
    end

    def show
      @users_array = User.programmers.map { |user| ["#{user.name} #{user.surname}", user.id] }
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)
      @project.user_id = current_user.id

      if @project.save
        # TODO: redirect to the project path (or use AJAX)
        flash[:notice] = "Project successfully created"
        redirect_to admin_project_path(@project)
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @project.update(project_params)
        flash[:notice] = "Project updated successfully"
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
      # TODO: move find to the method
      @user = User.find(params[:assign_user])
      @project.users << @user
    rescue ActiveRecord::RecordNotUnique
      flash[:error] = "User is already assigned to the project"
    else
      flash[:notice] = "User was successfully assigned to the project"
      redirect_to admin_project_path(@project)
    end

    def unassign_user
      @user = User.find(params[:assign_user])
      @project.users.delete(@user)
      flash[:notice] = "User was successfully unassigned"
      redirect_to admin_project_path(@project)
    end

    private

      def find_project
        @project = Project.find_by(slug: params[:slug])
      end

      def project_params
        params.require(:project).permit(:name, :description)
      end
  end
end
