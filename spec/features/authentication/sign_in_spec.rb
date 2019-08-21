require 'rails_helper'

feature 'User can login', %q{
  In order to be able create and manipulate projects and tasks,
  As a user
  I'd like to be able to login to the system
} do

  let!(:user) { create(:user) }
  let!(:admin) { create(:user, :admin) }

  background do
    visit login_path
  end

  scenario 'Registered user logins to the system' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'

    expect(page).to have_content "Welcome, #{user.name} #{user.surname}!"
    expect(current_path).to eq(root_path)
  end

  scenario 'Admin user logins to the system' do
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_on 'Log in'

    expect(page).to have_content "Welcome, administrator #{admin.name} #{admin.surname}!"
    expect(current_path).to eq(admin_projects_path)
  end

  scenario 'Unregistered user tries to sign in' do
    fill_in 'Email', with: 'randon@test.com'
    fill_in 'Password', with: '123456789'
    click_on 'Log in'

    expect(page).to have_content 'Wrong email and password combination'
  end
end
