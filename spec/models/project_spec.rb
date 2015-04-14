require 'rails_helper'

describe Project, focus: true do
  it { should belong_to(:user) }

  it { should have_valid(:name).when("Lift-Off", "The New Urban") }
  it { should_not have_valid(:name).when(
    " ", nil, "this name is too long because it's over 40 characters
    long", "eh") }

  it { should have_valid(:proposal).when(
    "This is a test proposal. It should pass because it is at
    least fifty characters long.") }
  it { should_not have_valid(:proposal).when(
    " ", nil, "too short a proposal. not fifty characters") }

  it 'each project name should be unique for a given user' do
    project = FactoryGirl.create(:project)
    project_with_same_name = FactoryGirl.build(:project, name: project.name, user: project.user)

    expect(project_with_same_name).to_not be_valid
    expect(project_with_same_name.errors[:name]).to_not be_blank
  end

  it 'each project proposal should be unique for a given user' do
    project = FactoryGirl.create(:project)
    project_with_same_proposal = Project.new(
      name: "This name is irrelevant",
      proposal: project.proposal, user: project.user)

    expect(project_with_same_proposal).to_not be_valid
    expect(project_with_same_proposal.errors[:proposal]).to_not be_blank
  end

  it 'each project must be tagged with at least two unique skills
  (not case sensitive)' do
    project = FactoryGirl.build(:project, skill_list: "coding, Coding")

    expect(project).to_not be_valid
    expect(project.errors[:skill_error]).to_not be_blank
  end

  it "project endures even after it's user is destroyed" do
    project = FactoryGirl.create(:project)
    project.user.destroy

    expect(project).to be_valid
  end
end
