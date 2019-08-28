require "rails_helper"

feature "Administrator can assign users to the project", %q{
  In order to be able to show user the project
  As an administrator
  I'd like to assign user to the project
} do

  let!(:admin) { create(:user, :admin) }
  let!(:project) { create(:project, author: admin) }
  let!(:task) { create(:task, author: admin, performer: nil, project: project) }

  let!(:valid_comment) { "Test comment with enough length more than 25 characters" }
  let!(:invalid_comment) { "Invalid comment" }

  background do
    sign_in admin
    visit admin_task_path(task)
  end

  scenario "Admin adds comment", :js do

    click_on "Comments"

    fill_in "Write your comment:", with: valid_comment
    click_on "Post comment"

    sleep 0.5

    expect(page).to have_css(".project-comments")
    expect(page).to have_css(".comment")
    expect(page).to have_content(valid_comment)
  end

  scenario "Admin adds invalid comment", :js do

    click_on "Comments"

    fill_in "Write your comment:", with: invalid_comment
    click_on "Post comment"

    sleep 0.5

    expect(page).not_to have_css(".project-comments")
    expect(page).not_to have_css(".comment")
    expect(page).not_to have_content(valid_comment)
    expect(page).to have_content("Errors detected:")
  end
end