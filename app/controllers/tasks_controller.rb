class TasksController < ApplicationController

  find :project, :slug
  find :task, :id

  before_action :find_project, only: %i(index new create)
  before_action :find_task, only: %i(destroy edit update show summary)

  before_action :authenticate_user!
  before_action :authenticate_admin!, only: %i(new create destroy)

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
      redirect_to task_path(@task)
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

    def task_params
      params.require(:task).permit(:name, :description, :start_date, :due_date, :task_type, :priority, :complete_hours)
    end
end
