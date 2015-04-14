require 'rails_helper'

feature 'user views their profile page', %Q{
  As a signed up user I want to sign in and view my profile page.
} do
  context "as a signed in user" do
    let!(:user) do
      FactoryGirl.create(:user, skill_list: "python, screen printing",
      interest_list: "urban design, indie film")
    end
    let!(:project_one) { FactoryGirl.create(:project, user: user) }
    let!(:project_two) { FactoryGirl.create(:project, user: user) }

    scenario 'view your own profile' do
      sign_in_as(user)

      click_link("My Profile")

      expect(page).to have_content(user.username)
      expect(page).to have_content(user.about_me)
      # eventually add expect picture
      expect(page).to have_content(project_one.name)
      expect(page).to have_content(project_two.name)
      expect(page).to have_content("screen printing")
      expect(page).to have_content("indie film")
    end

    scenario "a signed in user can view someone elses profile" do
      other_user = user
      user = FactoryGirl.create(:user)

      sign_in_as(user)

      visit user_path(other_user)
      expect(page).to have_content(other_user.username)
      expect(page).to have_content(other_user.about_me)
      # eventually add expect picture
      expect(page).to have_content(project_one.name)
      expect(page).to have_content(project_two.name)
      expect(page).to have_content("screen printing")
      expect(page).to have_content("indie film")
    end
  end

  scenario "user that is not signed in can't view their own profile" do
    visit new_user_session_path

    expect(page).to_not have_content('My Profile')
  end

  scenario "guest can't view another user's profile" do
    user = FactoryGirl.create(:user)

    visit user_path(user)

    expect(page).to have_content("You need to sign in or sign up before continuing")
  end
end
