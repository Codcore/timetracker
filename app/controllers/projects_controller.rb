class ProjectsController < ApplicationController

  before_action :find_project, only: %i(show destroy edit update)

  def index
    @projects = Project.all.includes(:author).paginate(page: params[:page], per_page: 10)
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

  private

    def find_project
      @project = Project.find_by(slug: params[:slug])
    end

    def project_params
      params.require(:project).permit(:name, :description)
    end
end
