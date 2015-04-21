require 'rails_helper'

feature 'user registers', %Q{
  As a visitor
  I want to register
  So that I can create an account
} do

  # Acceptance Criteria:
  # * I must specify a valid email address,
  #   password, and password confirmation
  # * If I don't specify the required information, I am presented with
  #   an error message

  scenario 'provide valid registration information' do
    visit new_user_registration_path

    fill_in 'Username', with: 'craftyjohn'
    fill_in 'What are your skills?', with: 'rails, graphic design'
    fill_in 'What are your interests?',
      with: 'contemporary art, coffee bean roasting'
    fill_in 'Zip code', with: '02111'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'First name', with: "John"
    fill_in 'Last name', with: "Smith"
    fill_in 'About me', with: "Let me you a little about myself.
      I enjoy long walks on the beach..."
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'

    click_button 'Sign up'

    expect(page).to have_content('Welcome! You have signed up successfully.')
    expect(page).to have_content('Sign Out')
  end

  scenario 'provide invalid registration information' do
    visit new_user_registration_path

    click_button 'Sign up'
    expect(page).to have_content("can't be blank")
    expect(page).to_not have_content('Sign Out')
  end

  scenario 'password confirmation does not match confirmation' do
    visit new_user_registration_path
    click_button 'Sign up'


    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'differentpassword'
  end
end
