require_relative '../spec/support/factory_girl.rb'
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Faker::Internet.user_name
# Faker::Commerce.product_name

SKILLS = ["Adjusting",
          "Algorithms",
          "Analysis",
          "Analytical",
          "Applications",
          "Assembling",
          "Balancing",
          "Calculating",
          "Certifications",
          "Coding",
          "Compiling Statistics",
          "Computer",
          "Computing",
          "Configuration",
          "Customer Support",
          "Data",
          "Data Mining",
          "Database Design",
          "Database Management",
          "Debugging",
          "Design",
          "Development",
          "Document",
          "Documentation",
          "Drilling",
          "Driving",
          "Electronics",
          "Email",
          "Engineering",
          "Fabrication",
          "Finishing",
          "Follow Specifications",
          "Grinding",
          "Hardware",
          "Implementation",
          "Information Technology",
          "Infrastructure",
          "Languages",
          "Maintenance",
          "Manual Dexterity",
          "Mechanical",
          "Methodology",
          "Modeling",
          "Modification",
          "Needs Analysis",
          "Network Architecture",
          "Network Security",
          "Networking",
          "New Technologies",
          "Operating Systems",
          "Operations",
          "Performance",
          "Planning",
          "Platforms",
          "Photography",
          "Problem Solving",
          "Product Reliability",
          "Proficiency",
          "Project Management",
          "Programming",
          "Quality Assurance",
          "Quality Control",
          "Quantitative Research",
          "Quantitative Reports",
          "Refinishing",
          "Remodeling",
          "Repairing",
          "Reporting",
          "Restoration",
          "Security",
          "Servers",
          "Storage",
          "Software",
          "Solution Delivery",
          "Sorting",
          "Statistical Analysis",
          "Structures",
          "Systems Analysis",
          "Technical Support",
          "Technical Writing",
          "Technology",
          "Testing",
          "Tools",
          "Training",
          "Troubleshooting",
          "Usability"]


INTERESTS = ["Sports such as football, baseball, golf, soccer, tennis etc.",
            "Photography/Videography",
            "Movies and Theater",
            "Video games",
            "Traveling and Exploring different places",
            "Reading",
            "Listening to music",
            "Playing a musical instrument",
            "Dancing",
            "Acting",
            "Surfing the Internet/Blogging/Programming",
            "Gardening",
            "Collecting",
            "Bowling",
            "Iceskating",
            "Taking care of pets",
            "Trekking",
            "Fitness",
            "Extreme sports and activities (such as sky diving, mountain climbing etc.)",
            "Wine tasting",
            "Social work.",
            "Driving, go-karting. Riding motorbikes",
            "Car restoration and repairing",
            "Mountain climbing, biking.",
            "Fishing.",
            "Indoor games such as chess, cards (poker), pool or billiards.",
            "Carpentry.",
            "Brewing",
            "Fantasy sports",
            "Hunting",
            "Building models and miniatures",
            "Camping",
            "Body Building/Fitness",
            "Coaching and teaching.",
            "Astrology",
            "Astronomy",
            "Social work.",
            "Fashion designing",
            "Hair dressing/hair styling",
            "Nail art",
            "Photography",
            "Interior designing",
            "Gardening",
            "Yoga, meditation.",
            "Baking/cooking.",
            "Diet and nutrition.",
            "Health and fitness",
            "Knitting, sewing.",
            "Dancing.",
            "Singing/music.",
            "Coaching and teaching.",
            "Jewelry making.",
            "Painting.",
            "Pottery, sculpture.",
            "Astrology, tarot card reading.",
            "Knitting",
            "Social work",
            "Candle making",
            "Iceskating"]


# if Rails.env.development?
#   FactoryGirl.build(:project)
# end

50.times do
  project = FactoryGirl.create(
  :project, name: Faker::Commerce.product_name, skill_list: SKILLS.sample(4).join(", "),
  interest_list: INTERESTS.sample(4).join(", "))

  project.user.update(username: Faker::Internet.user_name, skill_list: SKILLS.sample(4).join(", "), interest_list: INTERESTS.sample(4).join(", "))
end
