require 'rails_helper'

feature "edit user account", %q(As a user I want edit my own account) do
  let!(:user) { FactoryGirl.create(:user) }

  scenario "Authenticated user successfully edits they're own account" do
    current_user = user

    sign_in_as(current_user)
    visit user_path(current_user)
    click_on("Edit My Profile")
    fill_in "What are your skills?", with: "surfing, water colors"
    fill_in "What are your interests?", with: "contemporary art, urban planning"
    fill_in "Current password", with: current_user.password
    click_on("Update Profile")

    expect(page).to have_content("Your account has been updated successfully")

    visit user_path(current_user)

    expect(page).to have_content("water colors")
    expect(page).to have_content("urban planning")
  end

  scenario "user can not edit another user's account" do
    other_user = FactoryGirl.create(:user)

    sign_in_as(other_user)
    visit user_path(user)

    expect(page).to_not have_content("Edit Profile")
  end
end
