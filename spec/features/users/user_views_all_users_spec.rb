require 'rails_helper'

feature 'user views a list of all users', %Q{
  As a signed in user I want to see a list of all users and be able to
  navigate to their profiles
} do
  scenario "signed in user views a list of all users and can navigate to
    their profiles" do
    user = FactoryGirl.create(:user)
    sign_in_as user

    user_one = FactoryGirl.create(:user)
    user_two = FactoryGirl.create(:user)

    visit users_path

    expect(page).to have_content(user_one.username)
    expect(page).to have_content(user_two.username)

    click_link(user_one.username)
    expect(page).to have_content(user_one.about_me)
  end

  scenario 'guest unsuccessfully attempts to veiw all users' do
    visit users_path
    expect(page).to have_content("You need to sign in or sign up before continuing")
  end
end
