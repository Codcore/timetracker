require "rails_helper"

feature "Administrator can create comments for project", %q{
  In order to be able discuss the project
  As an administrator
  I'd like to add comments for project
} do

  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }

  let!(:project) { create(:project, author: admin) }
  let!(:task) { create(:task, author: admin, performer: nil, project: project) }

  let!(:valid_comment) { "Test comment with enough length more than 25 characters" }
  let!(:invalid_comment) { "Invalid comment" }


  describe "Administrator" do

    background do
      sign_in admin
      visit task_path(task)
    end

    scenario "Adds comment", :js do

      click_on "Comments"

      fill_in "Write your comment:", with: valid_comment
      click_on "Post comment"

      sleep 0.5

      expect(page).to have_css(".project-comments")
      expect(page).to have_css(".comment")
      expect(page).to have_content(valid_comment)
    end

    scenario "Adds invalid comment", :js do

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

  describe "User" do

    background do
      sign_in user
      visit task_path(task)
    end

    scenario "Adds comment", :js do

      click_on "Comments"

      fill_in "Write your comment:", with: valid_comment
      click_on "Post comment"

      sleep 0.5

      expect(page).to have_css(".project-comments")
      expect(page).to have_css(".comment")
      expect(page).to have_content(valid_comment)
    end

    scenario "Adds invalid comment", :js do

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
end