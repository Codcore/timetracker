class TaskPerformersController < ApplicationController

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

  private

    def find_task
      @task = Task.find(params[:task_id])
    end
end
