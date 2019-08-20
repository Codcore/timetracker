require 'rails_helper'

feature 'User can register an account', %q{
  In order to be able create and manipulate projects and tasks,
  As a guest
  I'd like to create personal account
} do

  before do
    visit new_user_path
  end

  scenario 'User creates account' do
    fill_in 'Name', with: 'Andrew'
    fill_in 'Surname', with: 'Yaroschuk'
    fill_in 'Email', with: 'user@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'

    click_on 'Sign up'

    expect(page).to have_content('Account successfully created.')
  end

  scenario 'User creates account with errors' do
    click_on 'Sign up'


    expect(page).to have_content("Name can\'t be blank")
    expect(page).to have_content("Email can\'t be blank")
    expect(page).to have_content("Surname can\'t be blank")
    expect(page).to have_content("Password can\'t be blank")
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password confirmation can\'t be blank")
    expect(page).to have_content("Password confirmation doesn\'t match Password")
  end
end