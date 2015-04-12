require 'rails_helper'

feature 'user views their profile page', %Q{
  As a signed up user I want to sign in and view my profile page.
} do
  scenario 'signed in user views their own profile' do
    project = FactoryGirl.create(:project)
    user = project.user
    skill_one = FactoryGirl.create(:user_skill)
    skill_two = FactoryGirl.create(:user_skill)

    visit new_user_session_path
    sign_is_as(user)
    click_link("My Profile")

    expect(page).to have_content(user.username)
    expect(page).to have_content(user.about_me)
    expect(page).to have_content(project.name)
    expect(page).to have_content(skill_one)
    expect(page).to have_content(skill_two)
  end


  scenario "user that is not signed in can't view their profile" do
    visit new_user_session_path

    click_button 'Log in'
    expect(page).to_not have_content('My Profile')
  end
end
