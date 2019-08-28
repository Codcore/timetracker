require "rails_helper"

feature "Administrator can delet time log records", %q{
  In order to be able to delete wrong time log records
  As an administrator
  I'd like to delete time log records for task
} do

  let!(:admin) { create(:user, :admin) }
  let!(:project) { create(:project, author: admin) }
  let!(:task) { create(:task, author: admin, project: project) }

  let!(:comment) { "Time log record comment" }
  let!(:hours) { 5 }

  background do
    sign_in admin
    visit admin_task_path(task)
  end

  scenario "Admin deletes time log record", :js do
    click_on "Time log"

    fill_in "Hours", with: hours
    fill_in "Commentary", with: comment
    click_on "Add time log record"

    accept_confirm do
      click_on("Delete")
    end

    expect(page).not_to have_css("table")
    expect(page).not_to have_content(hours)
    expect(page).not_to have_content(comment)
  end
end