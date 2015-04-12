require 'rails_helper'

feature 'user views their profile page', %Q{
  As a signed up user I want to sign in and view my profile page.
} do
  context "as a signed in user" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:project_one) { FactoryGirl.create(:project, user: user) }
    let!(:project_two) { FactoryGirl.create(:project, user: user) }
    let!(:skill_one) { FactoryGirl.create(:user_skill, user: user) }
    let!(:skill_two) { FactoryGirl.create(:user_skill, proficiency: 3, user: user) }

    scenario 'view your own profile' do
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
      click_link("My Profile")

      expect(page).to have_content(user.username)
      expect(page).to have_content(user.about_me)
      # eventually add expect picture
      expect(page).to have_content(project_one.name)
      expect(page).to have_content(project_two.name)
      expect(page).to have_content(skill_one.skill.name)
      expect(page).to have_content(skill_two.skill.name)
      expect(page).to have_content(skill_two.proficiency)
    end

    scenario "a signed in user can view someone elses profile" do
      other_user = user
      user = FactoryGirl.create(:user)

      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      click_button 'Log in'
      visit user_path(other_user)
      expect(page).to have_content(other_user.username)
      expect(page).to have_content(other_user.about_me)
      # eventually add expect picture
      expect(page).to have_content(project_one.name)
      expect(page).to have_content(project_two.name)
      expect(page).to have_content(skill_one.skill.name)
      expect(page).to have_content(skill_two.skill.name)
      expect(page).to have_content(skill_two.proficiency)
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
