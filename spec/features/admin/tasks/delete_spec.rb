require "rails_helper"

feature "Administrator can delete tasks for the project", %q{
  In order to be able to remove task from project
  As an administrator
  I'd like to delete a task from project
} do

  let!(:admin) { create(:user, :admin) }
  let!(:project) { create(:project, author: admin) }
  let!(:task) { create(:task, author: admin, performer: nil, project: project) }

  background do
    sign_in admin
    visit admin_task_path(task)
  end

  scenario "Admin deletes task from tasks view", :js do
    expect(page).to have_css ".task-card"

    accept_confirm do
      click_on "Delete task"
    end

    sleep 0.5

    expect(page).not_to have_css ".task-card"
  end

  scenario "Admin deletes task from tasks list", :js do
    click_on "Tasks"

    accept_confirm do
      click_on "Delete task"
    end

    sleep 1

    expect(page).not_to have_css ".task-#{task.id}"
  end
end