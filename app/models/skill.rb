class Skill < ActiveRecord::Base
  has_many :user_skills, dependent: :destroy
  has_many :users, through: :user_skills
  has_many :project_skills, dependent: :destroy
  has_many :projects, through: :project_skills

  validates :name,
    presence: true,
    length: { minimum: 3, maximum: 25 },
    uniqueness: true
end
