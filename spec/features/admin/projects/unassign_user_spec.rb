require 'rails_helper'

feature 'Administrator can unassign users to the project', %q{
  In order to be able to unassign user from the project
  As an administrator
  I'd like to unassign user from the project
} do

  let!(:admin) { create(:user, :admin) }

  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }

  let!(:project) { create(:project, author: admin) }

  background do
    sign_in admin
  end

  scenario 'Administrator assigns user to the project' do
    name_1 = "#{user_1.name} #{user_1.surname}"
    name_2 = "#{user_2.name} #{user_2.surname}"
    default_option = "Select user to assign to the project..."

    visit admin_project_path(project)

    expect(page).to have_select(:options => [name_1, name_2, default_option])

    page.select("#{user_1.name} #{user_1.surname}", from: "assign_user")
    click_on "Assign user"

    expect(page).to have_select(:options => [name_2, default_option])

    within ".user-assign" do
      click_on "Unassign user"
    end

    expect(page).to have_select(:options => [name_1, name_2, default_option])
  end
end
