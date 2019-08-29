require "rails_helper"

feature "Administrator can edit tasks for the project", %q{
  In order to be able to change task for project
  As an administrator
  I'd like to edit project task
} do

  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }

  let!(:project) { create(:project, author: admin) }
  let!(:task) { create(:task, author: admin, project: project) }

  let(:task_name) { "Test" }
  let(:task_description) { "Test description" }
  let(:edited_task_description) { "Test description#{task.description}" }


  describe "Administrator" do

    background do
      sign_in admin
      visit task_path(task)
    end

    scenario "Edits task", :js do

      within ".task-#{task.id}" do
        click_on "Edit task"
      end

      expect(page).to have_content("Edit task")

      within ".edit_task" do
        fill_in "Name", with: task_name

        within_frame("task_description_ifr") do
          editor = page.find_by_id("tinymce")
          editor.native.send_keys task_description
        end

        page.find("#task_start_date").set(Date.today)
        page.find("#task_due_date").set(Date.tomorrow)

        choose("bug")
        choose("normal")

        fill_in "Estimated hours", with: 10
        click_on "Save task"
      end

      within ".task-content" do
        expect(page).to have_content edited_task_description
      end

      click_on "Summary"

      within "table" do
        expect(page).to have_content task_name
        expect(page).to have_content "bug"

        within ".badge-danger" do
          expect(page).to have_content("bug")
        end

        within ".badge-primary" do
          expect(page).to have_content("normal")
        end
      end

      expect(page).to have_content "Edit task"
      expect(page).to have_content "Delete task"
    end

    scenario "Edits task with invalid data", :js do

      within ".task-#{task.id}" do
        click_on "Edit task"
      end

      expect(page).to have_content("Edit task")

      within ".edit_task" do
        fill_in "Name", with: ''

        within_frame("task_description_ifr") do
          editor = page.find_by_id("tinymce")
          editor.native.send_keys task_description
        end

        page.find("#task_start_date").set(Date.today)
        page.find("#task_due_date").set(Date.tomorrow)

        choose("bug")
        choose("normal")

        fill_in "Estimated hours", with: ''
        click_on "Save task"

        sleep 0.5
      end

      expect(page).to have_css(".task-errors")
    end
  end

  describe "User" do

    background do
      sign_in user
      visit task_path(task)
    end

    scenario "Edits task", :js do

      within ".task-#{task.id}" do
        click_on "Edit task"
      end

      expect(page).to have_content("Edit task")

      within ".edit_task" do
        fill_in "Name", with: task_name

        within_frame("task_description_ifr") do
          editor = page.find_by_id("tinymce")
          editor.native.send_keys task_description
        end

        page.find("#task_start_date").set(Date.today)
        page.find("#task_due_date").set(Date.tomorrow)

        choose("bug")
        choose("normal")

        fill_in "Estimated hours", with: 10
        click_on "Save task"
      end

      within ".task-content" do
        expect(page).to have_content edited_task_description
      end

      click_on "Summary"

      within "table" do
        expect(page).to have_content task_name
        expect(page).to have_content "bug"

        within ".badge-danger" do
          expect(page).to have_content("bug")
        end

        within ".badge-primary" do
          expect(page).to have_content("normal")
        end
      end

      expect(page).to have_content "Edit task"
      expect(page).not_to have_content "Delete task"
    end

    scenario "Edits task with invalid data", :js do

      within ".task-#{task.id}" do
        click_on "Edit task"
      end

      expect(page).to have_content("Edit task")

      within ".edit_task" do
        fill_in "Name", with: ''

        within_frame("task_description_ifr") do
          editor = page.find_by_id("tinymce")
          editor.native.send_keys task_description
        end

        page.find("#task_start_date").set(Date.today)
        page.find("#task_due_date").set(Date.tomorrow)

        choose("bug")
        choose("normal")

        fill_in "Estimated hours", with: ''
        click_on "Save task"

        sleep 0.5
      end

      expect(page).to have_css(".task-errors")
    end
  end
end
