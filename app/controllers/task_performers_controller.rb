class TaskPerformersController < ApplicationController

  find :task

  before_action :find_task

  before_action :authenticate_admin!, only: %i(create destroy)

  def create
    @task.performer = User.find(params[:performer_id])
    @task.save
    redirect_back fallback_location: task_path(@task)
  end

  def destroy
    @task.performer = nil
    @task.save
    redirect_back fallback_location: task_path(@task)
  end
end
