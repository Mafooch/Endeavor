class ProjectSkill < ActiveRecord::Base
  belongs_to :project
  belongs_to :skill

  validates :project_id,
    numericality: true,
    presence: true

  validates :skill_id,
    numericality: true,
    presence: true

  validates :project,
    uniqueness: { scope: :skill,
      message: "You have already added this skill"}
      
  validates :proficiency,
    numericality: {
      greater_than_or_equal_to: 1,
      less_than_or_equal_to: 5,
      only_integer: true },
    allow_nil: true
end
