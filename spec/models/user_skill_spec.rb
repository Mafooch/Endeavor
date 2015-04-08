require 'rails_helper'
describe UserSkill, focus: true do
  it { should belong_to(:user) }
  it { should belong_to(:skill) }

  it 'each user skill (combination of skill_id & user_id) must be unique' do
    user_skill = FactoryGirl.create(:user_skill)
    same_user_with_same_skill = UserSkill.new(
      skill_id: user_skill.skill_id, user_id: user_skill.user_id)
      
    expect(same_user_with_same_skill).to_not be_valid
    expect(same_user_with_same_skill.errors[:user]).to_not be_blank
  end
end
