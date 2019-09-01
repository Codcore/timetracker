class TimeLogsController < ApplicationController

  find :task
  find :time_log

  before_action :find_task, only: [:index, :create]
  before_action :find_time_log, only: [:destroy]

  before_action :authenticate_user!
  before_action :authenticate_admin!, only: %i(destroy)

  def index
    @project = @task.project
    @time_log = TimeLog.new
    @time_logs = TimeLog.for_task_and_user(@task, current_user)
  end

  def create
    @time_log = @task.time_logs.new(time_log_params)
    @time_log.author_id = current_user.id

    if @time_log.save
      redirect_back fallback_location: task_time_logs_path(@time_log.task)
    else
      @project = @time_log.task.project
      @time_logs = TimeLog.for_task_and_user(@task, current_user)
      render :index
    end
  end

  def destroy
    @time_log.destroy
    redirect_back fallback_location: task_time_logs_path(@time_log.task)
  end

  private

    def time_log_params
      params.require(:time_log).permit(:hours, :commentary)
    end
end
