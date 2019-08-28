require 'rails_helper'

feature 'Administrator can create tasks for the project', %q{
  In order to be able to add task for project
  As an administrator
  I'd like to create a new task
} do

  let!(:admin) { create(:user, :admin) }
  let!(:project) { create(:project, author: admin) }

  background do
    sign_in admin
    visit admin_project_path(project)
  end

  scenario 'Administrator creates project', :js do
    task_name = 'Test task'
    task_description = 'Test task description'

    click_on 'Tasks'
    click_on 'Add task to the project'

    within '#new_task' do
      expect(page).to have_content('New task')
      fill_in 'Name', with: task_name

      within_frame("task_description_ifr") do
        editor = page.find_by_id('tinymce')
        editor.native.send_keys task_description
      end

      page.find('#task_start_date').set(Date.today)
      page.find('#task_due_date').set(Date.tomorrow)

      choose('bug')
      choose('normal')

      fill_in 'Estimated hours', with: 10
      click_on 'Add task'
    end

    expect(page).to have_content 'Add task to the project'

    within '.task-header' do
      expect(page).to have_content task_name
    end

    within '.task-content' do
      expect(page).to have_content task_description
    end

    within '.badge-danger' do
      expect(page).to have_content('bug')
    end

    within '.badge-primary' do
      expect(page).to have_content('normal')
    end

    expect(page).to have_content 'Edit task'
    expect(page).to have_content 'Delete task'
  end

  scenario 'Administrator creates project with invalid data', :js do
    task_name = ''
    task_description = 'Test task description'

    click_on 'Tasks'
    click_on 'Add task to the project'

    within '#new_task' do
      expect(page).to have_content('New task')
      fill_in 'Name', with: task_name

      within_frame("task_description_ifr") do
        editor = page.find_by_id('tinymce')
        editor.native.send_keys task_description
      end

      fill_in 'Estimated hours', with: 10
      click_on 'Add task'

      sleep 0.5
    end

    expect(page).to have_css('.task-errors')
  end
end