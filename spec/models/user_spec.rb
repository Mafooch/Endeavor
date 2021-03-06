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
end
