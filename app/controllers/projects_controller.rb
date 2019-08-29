class ProjectsController < ApplicationController

  MSG_PROJECT_CREATED = "Project successfully created"
  MSG_PROJECT_UPDATED = "Project updated successfully"

  find :project, :slug

  before_action :find_project, only: %i(show destroy edit update)

  before_action :authenticate_user!
  before_action :authenticate_admin!, only: %i(new create edit update destroy)

  def index
    if current_user.admin?
      @projects = Project.all
                      .includes(:author)
                      .paginate(page: params[:page], per_page: 10)
    else
      @projects = current_user.projects
                      .includes(:author)
                      .paginate(page: params[:page], per_page: 10)
    end
  end

  def show; end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id

    if @project.save
      flash[:notice] = MSG_PROJECT_CREATED
      redirect_to @project
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update(project_params)
      flash[:notice] = MSG_PROJECT_UPDATED
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  private

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
