require 'rails'

feature 'user views a list of projects', %Q{
  As a signed up user I want to sign in as view a list of projects
} do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project,
    skill_list: "set design, carpentry", interest_list: "screenplay, history") }
  context "as a signed in user" do
    scenario 'view list of projects' do
      sign_in_as(user)
      visit projects_path

      expect(page).to have_content(project.name)
    end

    scenario "view a particular project and it's details" do
      sign_in_as(user)
      visit project_path(project)

      expect(page).to have_content(project.name)
      expect(page).to have_content(project.proposal)
      expect(page).to have_content("set design")
      expect(page).to have_content("screenplay")
    end
  end

  context "as a guest" do
    scenario 'I can not see a list of projects' do
      visit projects_path

      expect(page).to have_content("You need to sign in or sign up before continuing")
    end

    scenario "As a guest, I can't see a particular project and it's details" do
      visit project_path(project)

      expect(page).to have_content("You need to sign in or sign up before continuing")
    end
  end

end
