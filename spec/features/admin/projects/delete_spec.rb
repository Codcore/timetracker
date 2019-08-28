require "rails_helper"

feature "Administrator can delete projects", %q{
  In order to be able to remove old projects,
  As an administrator
  I'd like to delete project
} do

  let!(:admin) { create(:user, :admin) }
  let!(:project) { create(:project, author: admin) }

  background do
    sign_in admin
    visit admin_project_path(project)
  end

  scenario "Administrator deletes project", js: true do
    accept_confirm do
      click_link "Delete"
    end

    expect(current_path).to eq admin_projects_path
    expect(page).not_to have_content(project.name)
  end
end