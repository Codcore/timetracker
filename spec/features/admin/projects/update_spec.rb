require 'rails_helper'

feature 'Administrator can update projects', %q{
  In order to be able to change projects details,
  As an administrator
  I'd like to edit project
} do

  let!(:admin) { create(:user, :admin) }
  let!(:project) { create(:project, author: admin) }

  background do
    sign_in admin
    visit admin_project_path(project)
    click_on 'Edit'
  end

  scenario 'Administrator edits project' do
    fill_in 'Name', with: 'New project name'
    fill_in 'Description', with: 'New project description'
    click_on 'Update project'

    expect(page).to have_content 'New project name'
    expect(page).to have_content 'New project description'
    expect(page).to have_content 'Project updated successfully'
    expect(current_path).to eq admin_project_path(project)
  end

  scenario 'Administrator edits project with invalid data' do
    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    click_on 'Update project'

    expect(page).to have_content "Name can\'t be blank"
  end
end

