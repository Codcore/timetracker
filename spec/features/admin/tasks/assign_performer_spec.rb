require "rails_helper"

feature "Administrator can assign users for tasks", %q{
  In order to be able to delegate user for task
  As an administrator
  I'd like to assign task performer
} do

  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let!(:admin) { create(:user, :admin) }
  let!(:project) { create(:project, author: admin, users: [user]) }
  let!(:task) { create(:task, author: admin, performer: nil, project: project) }


  describe "Asministrator" do

    background do
      sign_in admin
      visit task_path(task)
    end

    scenario "Assigns user as a performer", :js do
      click_on "Assign performer"

      within ".dropdown-menu" do
        expect(page).to have_content "#{user}"
        expect(page).not_to have_content "#{another_user}"
      end

      click_on "#{user}"
      expect(page).to have_content("Unassign performer: #{user}")

      accept_confirm do
        click_on "Unassign performer: #{user}"
      end

      expect(page).to have_content("Assign performer")
    end
  end


  describe "User" do

    background do
      sign_in another_user
      visit task_path(task)
    end

    scenario "Can't assign users as performers", :js do
      expect(page).not_to have_content("Assign performer")
    end
  end
end
