require 'rails_helper'

feature "delete a project", %q(
  As a user I want to delete one of the projects i made
) do
  let!(:project) { FactoryGirl.create(:project) }

  scenario "Authenticated user successfully deletes a project they made" do
    project_owner = project.user

    sign_in_as(project_owner)
    visit project_path(project)
    click_on("Delete My Project")

    expect(page).to have_content("Project deleted successfully")

    visit projects_path

    expect(page).to_not have_content(project.name)
  end

  scenario "user that doesn't own the project unsuccessfully attempts to delete it" do
    other_user = FactoryGirl.create(:user)

    sign_in_as(other_user)
    visit project_path(project)

    expect(page).to_not have_content("Delete My Project")
  end
end
