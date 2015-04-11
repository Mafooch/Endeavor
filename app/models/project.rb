class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  validates :name,
    presence: true,
    length: { minimum: 3, maximum: 40 },
    uniqueness: { scope: :user,
      message: "You already have a project by the same name" }

  validates :proposal,
    presence: true,
    length: { minimum: 50 },
    uniqueness: { scope: :user,
      message: "You already have a project with the same proposal" }
end
