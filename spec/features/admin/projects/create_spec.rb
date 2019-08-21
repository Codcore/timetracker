require 'rails_helper'

feature 'Administrator can create projects', %q{
  In order to be able to add new projects,
  As an administrator
  I'd like to create project
} do

  let!(:admin) { create(:user, admin: true) }

  background do
    sign_in admin
  end

  scenario 'Administrator add a new project' do
    click_on 'Add project'
    expect(page).to have_content("New Project")

    fill_in 'Name', with: 'Test project'
    fill_in 'Description', with: 'Test project description'
    click_on 'Create project'

    expect(page).to have_content 'Test project'
  end

  scenario 'Administrator add a new project with invalid data' do
    click_on 'Add project'

    fill_in 'Name', with: ''
    fill_in 'Description', with: ''
    click_on 'Create project'

    expect(page).to have_content "Name can\'t be blank"
  end
end
