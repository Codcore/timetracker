require "rails_helper"

feature "Administrator can delete projects", %q{
  In order to be able to remove old projects,
  As an administrator
  I'd like to delete project
} do

  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }

  let!(:project) { create(:project, author: admin) }


  describe "Administrator" do

    background do
      sign_in admin
      visit project_path(project)
    end

    scenario "Deletes project", js: true do
      accept_confirm do
        click_link "Delete"
      end

      expect(current_path).to eq projects_path
      expect(page).not_to have_content(project.name)
    end
  end

  describe "User" do

    background do
      sign_in user
      visit project_path(project)
    end

    scenario "Can't delet project", js: true do
      expect(page).not_to have_content("Delete")
    end
  end
end
