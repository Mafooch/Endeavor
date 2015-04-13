class Project < ActiveRecord::Base
  belongs_to :user
  has_many :project_skills, dependent: :destroy
  has_many :skills, through: :project_skills

  acts_as_taggable_on :skills

  # before_save :proper_skill_list

  validate :at_least_2_skills
  validates :name,
    presence: true,
    length: { minimum: 3, maximum: 40 },
    uniqueness: { scope: :user,
      message: "You already have a project by the same name" }

  validates :proposal,
    presence: true,
    length: { minimum: 5 },
    uniqueness: { scope: :user,
      message: "You already have a project with the same proposal" }


  def at_least_2_skills
    # if we return false in a callback the record will not be saved
    if skill_list.count >= 2
      true
    else
      errors.messages[:skill_error] = ["not enough skills"] # change error message appropriately
      false
    end
  end
end
