class Project < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable_on :skills
  acts_as_taggable_on :interests

  validate :at_least_2_skills
  validate :at_least_2_interests
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

  def at_least_2_skills
    # if we return false in a callback the record will not be saved
    if skill_list.count >= 2
      true
    else
      errors.messages[:skill_error] = ["not enough skills"] # change error message appropriately
      false
    end
  end

  def at_least_2_interests
    # if we return false in a callback the record will not be saved
    if interest_list.count >= 2
      true
    else
      errors.messages[:interest_error] = ["not enough interests"] # change error message appropriately
      false
    end
  end
end
