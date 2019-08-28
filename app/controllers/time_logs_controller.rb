class TimeLogsController < ApplicationController

  before_action :find_task, only: [:index, :create]
  before_action :find_time_log, only: [:destroy]

  before_action :authenticate_user!
  before_action :authenticate_admin!, only: %i(destroy)

  def index
    @project = @task.project
    @time_log = TimeLog.new
    @time_logs = TimeLog.all.where(task_id: @task.id)
  end

  def create
    @time_log = @task.time_logs.new(time_log_params)

    if @time_log.save
      redirect_back fallback_location: task_time_logs_path(@time_log.task)
    else
      @project = @time_log.task.project
      @time_logs = TimeLog.all.where(task_id: @task.id)
      render :index
    end
  end

  def destroy
    @time_log.destroy
    redirect_back fallback_location: task_time_logs_path(@time_log.task)
  end

  private

    def find_task
      @task = Task.find(params[:task_id])
    end

    def find_time_log
      @time_log = TimeLog.find(params[:id])
    end

    def time_log_params
      params.require(:time_log).permit(:hours, :commentary)
    end
end
