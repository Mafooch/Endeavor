require 'rails_helper'

feature "delete user account", %q(As a user I want delete my own account) do
  let!(:user) { FactoryGirl.create(:user) }

  scenario "Authenticated user successfully deletes they're own account" do
    sign_in_as(user)
    visit user_path(user)
    click_on("Edit My Profile")
    click_on("Cancel my account")
    expect(page).to have_content("Your account has been successfully cancelled")

    visit users_path

    expect(page).to_not have_content(user.username)
  end
end
