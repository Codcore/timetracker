module Admin
  class TaskPerformersController < AdminController
    before_action :find_task

    def create
      @task.performer = User.find(params[:performer_id])
      @task.save
      p @task.errors
      redirect_back fallback_location: admin_task_path(@task)
    end

    def destroy
      @task.performer = nil
      @task.save
      redirect_back fallback_location: admin_task_path(@task)
    end

    private

      def find_task
        @task = Task.find(params[:task_id])
      end
  end
end
