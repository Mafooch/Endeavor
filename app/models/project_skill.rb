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
end
