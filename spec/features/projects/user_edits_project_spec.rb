require 'rails_helper'

feature "edit a project", %q(
  As a user I want to edit one of the projects i made
) do
  let!(:project) { FactoryGirl.create(:project) }

  scenario "Authenticated user successfully edits a project they made" do
    project_owner = project.user

    sign_in_as(project_owner)
    visit project_path(project)
    click_on("Edit My Project")

    fill_in "Name", with: "This is a test project name"
    fill_in "Proposal", with: "This is a test project proposal
    This is a test project proposal This is a test project proposal
    This is a test project proposal"
    fill_in "Useful skills for this project", with: "communication, law"
    fill_in "Interests relevant to this project", with: "environmental law, law"
    click_on("Update Project")

    expect(page).to have_content("Project updated successfully")

    visit project_path(project)

    expect(page).to have_content("This is a test project name")
    expect(page).to have_content("environmental law")
  end

  scenario "project unsuccessfully trys to edit a project making it invalid" do
    sign_in_as(project.user)
    visit project_path(project)
    click_on("Edit My Project")
    fill_in("Name", with: "a")
    click_on("Update Project")

    expect(page).to have_content("Update failed")
  end

  scenario "user that doesn't own the project unsuccessfully attempts to edit a
    project" do
    other_user = FactoryGirl.create(:user)

    sign_in_as(other_user)

    expect(page).to_not have_content("Edit My Project")
  end
end
