module Admin
  class ProjectsController < AdminController
    def index
      # TODO: make a pagination
      @projects = Project.all
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)

      if @project.save
        # TODO: redirect to the project path (or use AJAX)
        flash[:notice] = "Project successfully created"
        redirect_to admin_projects_path
      else
        render :new
      end
    end

    def update
    end

    def destroy
    end

    private

      def project_params
        params.require(:project).permit(:name, :description)
      end
  end
end
