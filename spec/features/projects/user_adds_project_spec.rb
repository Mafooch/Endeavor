require 'rails_helper'

feature "add a project", %q(
  As an user I want to add a project
) do

  scenario "Authenticated user successfully adds a project they made" do
    user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit user_path(user)
    click_on("Propose a new project!")
    fill_in "Name", with: "This is a test project name"
    fill_in "Proposal", with: "This is a test project proposal
    This is a test project proposal This is a test project proposal
    This is a test project proposal"
    fill_in "Useful skills for this project", with: "business communication, law"
    fill_in "Interests relevant to this project", with: "environmental law, law"
    click_button 'Create Project'

    expect(page).to have_content("Project created successfully!")

    visit projects_path

    expect(page).to have_content(user.projects.last.name)
  end

  scenario "User can not create a project from another users profile" do
    user = FactoryGirl.create(:user)
    other_user = FactoryGirl.create(:user)

    sign_in_as(user)
    visit user_path(other_user)

    expect(page).to_not have_content("Propose a new project!")
  end

  scenario "guest unsuccessfully attempts to add a project" do

    visit new_project_path
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end
end
