module Admin
  class ProjectsController < AdminController

    before_action :find_project, only: [:show, :destroy, :update]

    def index
      # TODO: make a pagination
      @projects = Project.all
    end

    def show
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)

      if @project.save
        # TODO: redirect to the project path (or use AJAX)
        flash[:notice] = "Project successfully created"
        redirect_to admin_project_path(@project)
      else
        render :new
      end
    end

    def update
    end

    def destroy
      @project.destroy
      redirect_to admin_projects_path
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
