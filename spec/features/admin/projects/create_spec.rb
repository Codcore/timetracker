require 'rails_helper'

feature 'Administrator can create projects', %q{
  In order to be able to add new projects,
  As a guest
  I'd like to create project
} do

  let!(:admin) { create(:user, admin: true) }

  before do
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
end
