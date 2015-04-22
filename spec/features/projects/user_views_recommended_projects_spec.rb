require 'rails_helper'

feature "user views their recommended projects", %Q{
  As a signed in user I want to view my recommended projects page
} do
  context "user and projects exist with tagged skills and interests" do
    let!(:user) do
      FactoryGirl.create(:user, skill_list: "ruby, rails,
      css, javascript, technical writing, video production",
      interest_list: "film, fitness, technology")
    end
    let!(:irrelevant_project) { FactoryGirl.create(:project) }
    let!(:relevant_project) do
      FactoryGirl.create(:project, skill_list: "ruby, rails")
    end
    let!(:most_relevant_project) do
      FactoryGirl.create(:project, skill_list: "ruby, python",
      interest_list: "film, big data")
    end
    scenario "view your recommended projects" do
      sign_in_as(user)
      visit recommended_projects_path

      expect(page).to have_content(relevant_project.name)
      expect(page).to have_content(most_relevant_project.name)
    end

    scenario "you can not see projects that aren't recommended" do
      sign_in_as(user)
      visit recommended_projects_path

      expect(page).to_not have_content(irrelevant_project.name)
    end
  end
end
