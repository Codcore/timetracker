require "rails_helper"

feature "Administrator can assign users to the project", %q{
  In order to be able to show user the project
  As an administrator
  I'd like to assign user to the project
} do

  let!(:admin) { create(:user, :admin) }

  let!(:user_1) { create(:user) }
  let!(:user_2) { create(:user) }

  let!(:project) { create(:project, author: admin) }


  describe "Asministrator" do

    background do
      sign_in admin
    end

    scenario "Assigns user to the project" do
      name_1 = "#{user_1.name} #{user_1.surname}"
      name_2 = "#{user_2.name} #{user_2.surname}"
      default_option = "Select user to assign to the project..."

      visit project_path(project)
      click_on "Members"

      expect(page).to have_select(:options => [name_1, name_2, default_option])

      page.select("#{user_1.name} #{user_1.surname}", from: "user_id")
      click_on "Assign user"

      expect(page).to have_select(:options => [name_2, default_option])

      within ".user-assign" do
        expect(page).to have_content(name_1)
      end

      page.select(name_2, from: "user_id")
      click_on "Assign user"

      within ".user-assign" do
        expect(page).to have_content(name_2)
      end
    end
  end

  describe "User" do

    background do
      sign_in user_1
    end

    scenario "Visits users assign page" do
      visit project_path(project)
      click_on "Members"

      expect(page).not_to have_content "Assign user"
    end
  end
end
