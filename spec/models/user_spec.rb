require 'rails_helper'

describe User do
  it { should have_many(:projects) }
  it { should have_many(:skills) }
  it { should have_many(:interests) }

  it { should have_valid(:username).when('crafts n stuff', 'artful dodger') }
  it { should_not have_valid(:username).when(
    ' ', 'eh', nil, 'this is way too long a username') }

  it { should have_valid(:email).when('test@yahoo.com', 'test2@gmail.com') }
  it { should_not have_valid(:email).when(' ', 'no.com', nil, 'wont@work') }

  it { should have_valid(:first_name).when('jack', 'Jill') }
  it { should_not have_valid(:first_name).when(
    ' ', nil, 'this is way too long a first name') }

  it { should have_valid(:last_name).when('Wittgenstein', 'Pannenburg') }
  it { should_not have_valid(:last_name).when(
    ' ', nil, 'this is way too long a last name') }

  it { should have_valid(:about_me).when(
    'Let me tell you a little about myself. You wanna sit down for this') }
  it { should_not have_valid(:about_me).when(' ', 'eh') }

  it 'has a matching password confirmation for the password' do
    user = FactoryGirl.create(:user)
    user.password = 'password'
    user.password_confirmation = 'anotherpassword'

    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end

  it "each user must be tagged with at least two unique skills
  (case sensitive)" do
    user = FactoryGirl.build(:user, skill_list: "coding, Coding")

    expect(user).to_not be_valid
    expect(user.errors[:skill_error]).to_not be_blank
  end

  it "each user must be tagged with at least two unique interests
  (case sensitive)" do
    user = FactoryGirl.build(:user, interest_list: "health tech, HEALTH tech")

    expect(user).to_not be_valid
    expect(user.errors[:interest_error]).to_not be_blank
  end

  context "user and projects exist with tagged skills and interests" do
    let!(:user) do
      FactoryGirl.create(:user, skill_list: "ruby, rails,
      css, javascript, technical writing, video production",
      interest_list: "film, fitness, technology")
    end
    let!(:irrelevant_project) { FactoryGirl.create(:user) }
    let!(:relevant_project) do
      FactoryGirl.create(:project, skill_list: "ruby, rails")
    end
    let!(:most_relevant_project) do
      FactoryGirl.create(:project, skill_list: "ruby, python",
      interest_list: "film, big data")
    end
    describe "#recommended_projects" do
      it "returns and orders the projects that best match the skills and
      interests of the user" do
        expect(user.recommended_projects[0][0]).to eq most_relevant_project
        expect(user.recommended_projects[1][0]).to eq relevant_project
      end

      it "does not return users that have no matches" do
        expect(user.recommended_projects.include?([irrelevant_project]) == false)
      end
    end

    describe "#project_matches" do
      it "returns a project's skills and interests that match the user's" do
        expect(user.project_matches(most_relevant_project).include?(
          {"interest" => "film"}))
        expect(user.project_matches(most_relevant_project).include?(
          {"skill" => "ruby"}))
      end
      it "does not return skills and interests that do not match" do
        expect(user.project_matches(most_relevant_project).include?(
          {"skill" => "ruby"}) == false)
      end
    end
  end
end
