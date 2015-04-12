require 'rails_helper'
describe ProjectSkill do
  it { should belong_to(:project) }
  it { should belong_to(:skill) }

  it { should have_valid(:proficiency).when(1, nil, 5) }
  it { should_not have_valid(:proficiency).when("string", 10, -3, 1.5) }

  it "each project skill (comboination of skill_id & user_id must be unique)" do
    project_skill = FactoryGirl.create(:project_skill)
    same_project_with_same_skill = ProjectSkill.new(
      skill_id: project_skill.skill_id, project_id: project_skill.project_id)

    expect(same_project_with_same_skill).to_not be_valid
    expect(same_project_with_same_skill.errors[:project]).to_not be_blank
  end
end
