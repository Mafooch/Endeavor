require 'rails_helper'
describe ProjectSkill do
  it { should belong_to(:project) }
  it { should belong_to(:skill) }

  it "each project skill (comboination of skill_id & user_id must be unique)" do
    project_skill = FactoryGirl.create(:project_skill)
    same_project_with_same_skill = ProjectSkill.new(
      skill_id: project_skill.skill_id, project_id: project_skill.project_id)

    expect(same_project_with_same_skill).to_not be_valid
    expect(same_project_with_same_skill.errors[:project]).to_not be_blank
  end
end
