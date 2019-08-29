require "rails_helper"

feature "Users can create projects", %q{
  In order to be able show project to user
  As asministrator
  I'd like to create new project
} do

  let!(:admin) { create(:user, admin: true) }
  let!(:user) { create(:user) }

  describe "Administrator" do

    scenario "Adds a new project and assigns user to it" do
      Capybara.using_session(:admin) do
        sign_in admin
        visit root_path

        click_on "New project"
        expect(page).to have_content("New Project")

        fill_in "Name", with: "Test project"
        fill_in "Description", with: "Test project description"
        click_on "Create project"

        expect(page).to have_content "Test project"

        click_on "Members"
        page.select("#{user.name} #{user.surname}", from: "user_id")
        click_on "Assign user"
      end

      Capybara.using_session(:user) do
        sign_in user
        visit root_path

        expect(page).to have_content "Test project description"
        expect(page).to have_content "Test project"
      end
    end

    scenario "Adds a new project with invalid data" do
      sign_in admin
      visit root_path

      click_on "New project"

      fill_in "Name", with: ""
      fill_in "Description", with: ""
      click_on "Create project"

      expect(page).to have_content "Name can\'t be blank"
    end
  end

  describe "User" do

    background do
      sign_in user
    end

    scenario "Can't create project" do
      expect(page).not_to have_content("New Project")
    end
  end
end
