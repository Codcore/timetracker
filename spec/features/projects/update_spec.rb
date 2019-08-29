require "rails_helper"

feature "Administrator can update projects", %q{
  In order to be able to change projects details,
  As an administrator
  I'd like to edit project
} do

  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }

  let!(:project) { create(:project, author: admin) }


  describe "Administrator", :js do

    background do
      sign_in admin
      visit project_path(project)
      click_on "Edit"
    end

    scenario "Edits project" do

      fill_in "Name", with: "New project name"

      within_frame("project_description_ifr") do
        editor = page.find_by_id("tinymce")
        editor.native.send_keys "New project description"
      end

      click_on "Update project"

      expect(page).to have_content "New project name"
      expect(page).to have_content "New project description"
      expect(page).to have_content "Project updated successfully"
      expect(current_path).to eq project_path(project)
    end

    scenario "Edits project with invalid data" do
      fill_in "Name", with: ""

      within_frame("project_description_ifr") do
        editor = page.find_by_id("tinymce")
        editor.native.send_keys ""
      end

      click_on "Update project"

      expect(page).to have_content "Name can\'t be blank"
      expect(current_path).to eq edit_project_path(project)
    end
  end

  describe "User", :js do

    background do
      sign_in user
      visit project_path(project)
    end

    scenario "Can't edit project" do
      expect(page).not_to have_content "Edit"
    end
  end
end
