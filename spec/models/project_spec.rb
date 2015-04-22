require 'rails_helper'

describe Project do
  it { should belong_to(:user) }
  it { should have_many(:skills) }
  it { should have_many(:interests) }

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
    project_with_same_name = FactoryGirl.build(:project, name: project.name,
    user: project.user)

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

  it "each project must be tagged with at least two unique interests
  (case sensitive)" do
    project = FactoryGirl.build(:project, interest_list: "health tech, HEALTH tech")

    expect(project).to_not be_valid
    expect(project.errors[:interest_error]).to_not be_blank
  end

  it "project endures even after it's user is destroyed" do
    project = FactoryGirl.create(:project)
    project.user.destroy

    expect(project).to be_valid
  end

  context "project and users exist with tagged skills and interests" do
    let!(:project) do
      FactoryGirl.create(:project, skill_list: "ruby, rails,
      css, javascript, technical writing, video production",
      interest_list: "film, fitness, technology")
    end
    let!(:irrelevant_user) { FactoryGirl.create(:user) }
    let!(:relevant_user) do
      FactoryGirl.create(:user, skill_list: "ruby, rails")
    end
    let!(:most_relevant_user) do
      FactoryGirl.create(:user, skill_list: "ruby, python",
      interest_list: "film, big data")
    end
    describe "#recommended_users" do
      it "returns and orders the users that best match the skills and interests
        of the project" do
        expect(project.recommended_users[0][0]).to eq most_relevant_user
        expect(project.recommended_users[1][0]).to eq relevant_user
      end

      it "does not return users that have no matches" do
        expect(project.recommended_users.include?([irrelevant_user]) == false)
      end
    end

    describe "#users_matches" do
      it "returns a user's skills and interests that match the project's" do
        expect(project.users_matches(most_relevant_user).include?(
          {"interest" => "film"}))
        expect(project.users_matches(most_relevant_user).include?(
          {"skill" => "ruby"}))
      end
      it "does not return skills and interests that do not match" do
        expect(project.users_matches(most_relevant_user).include?(
          {"skill" => "ruby"}) == false)
      end
    end
  end
end
