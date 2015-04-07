require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "username#{n}" }
    sequence(:email) {|n| "user#{n}@example.com" }
    password "password"
    password_confirmation "password"
    phone "(555)-555-5555"
    first_name "Kenny"
    last_name "Retarc"
    zip_code "02111"
    profile_pic "dfjlsjflka.jpg"
    about_me "A man of the people. Musical mastermind in need of a creative
      outlet"
  end
end
