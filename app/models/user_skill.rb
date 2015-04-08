class UserSkill < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill

  validates :user_id,
    numericality: true,
    presence: true

  validates :skill_id,
    numericality: true,
    presence: true

  validates :user,
    uniqueness: { scope: :skill,
      message: "You have already added this skill!"}
end
