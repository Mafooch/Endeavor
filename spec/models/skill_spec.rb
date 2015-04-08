require 'rails_helper'

describe Skill, focus: true do
  it { should have_many(:user_skills).dependent(:destroy) }
  it { should have_many(:users) }

  it { should have_valid(:name).when('wood-working', 'video production') }
  it { should_not have_valid(:name).when(
    ' ', 'eh', nil, 'this is way too long a skill name') }


  it 'each skill created must be unique' do
    skill = FactoryGirl.create(:skill)
    same_skill = Skill.new(name: skill.name)

    expect(same_skill).to_not be_valid
    expect(same_skill.errors[:name]).to_not be_blank
  end

# make tests to test dependencies. skill can't exist without some user
# possessing it

end
