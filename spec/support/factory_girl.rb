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

  factory :project do
    sequence(:name) { |n| "#{n}Test Project Name" }
    sequence(:proposal) do |n|
      "#{n}This is a test project proposal. Testin, testing, one, two, three!"
    end 

    user
  end

  factory :skill do
    sequence(:name) { |s| "skill#{s}" }
  end

  factory :user_skill do
    # might make sense to add a proficiency here
    user
    skill
  end

  factory :project_skill do
    project
    skill
  end
end
