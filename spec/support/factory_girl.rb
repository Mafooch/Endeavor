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
    profile_pic "http://facebookcraze.com/wp-content/uploads/2010/10/funny-sherlock-holmes-alternative-facebook-profile-picture.jpg"
    about_me "A man of the people. Musical mastermind in need of a creative
      outlet"

    sequence(:skill_list) { |n| "skill_one#{n}, skill_two#{n}" }
    sequence(:interest_list) { |n| "interest_one#{n}, interest_two#{n}" }
  end

  factory :project do
    sequence(:name) { |n| "#{n}Test Project Name" }
    sequence(:proposal) do |n|
      "#{n}This is a test project proposal. Testin, testing, one, two, three!"
    end

    sequence(:skill_list) { |n| "skillone#{n}, skilltwo#{n}" }
    sequence(:interest_list) { |n| "interest_one#{n}, interest_two#{n}" }
    
    user
  end
end
