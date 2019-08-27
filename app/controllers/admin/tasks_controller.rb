module Admin
  class TasksController < AdminController

    before_action :find_project, only: %i(index new create)
    before_action :find_task, only: %i(destroy edit update show summary)

    def index
      @task = Task.new
      @tasks = Task.all.where(project: @project)
    end

    def show
      @project = @task.project
    end

    def new
      @task = @project.tasks.build
    end

    def create
      @task = @project.tasks.new(task_params)
      @task.author_id = current_user.id
      @task.save
    end

    def edit
      @project = @task.project
    end

    def update
      @project = @task.project
      if @task.update(task_params)
        redirect_to admin_task_path(@task)
      else
        render :edit
      end
    end

    def destroy
      Task.destroy(@task.id)
    end

    def summary
      show
      render 'summary'
    end

    private

       def find_task
        @task = Task.find(params[:id])
       end

      def find_project
        @project = Project.find_by(slug: params[:project_slug])
      end
    
      def task_params
        params.require(:task).permit(:name, :description, :start_date, :due_date, :task_type, :priority, :complete_hours)
      end
  end
end
