require 'json'

class TaskMailer < ApplicationMailer

  def update_email
    @user = params[:user]
    @task = params[:task]
    @updates = JSON.parse(params[:updates])
    mail(to: @user.email, subject: "Task #{@task.name} was updated")
  end
end
