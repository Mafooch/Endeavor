class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :projects
  acts_as_taggable_on :skills
  acts_as_taggable_on :interests
  acts_as_tagger
  mount_uploader :profile_pic, ProfilePicUploader

  validate :at_least_2_skills
  validate :at_least_2_interests

  validates :username,
    presence: true,
    length: { minimum: 3, maximum: 15},
    uniqueness: true

  validates :first_name,
    presence: true,
    length: { maximum: 25 }

  validates :last_name,
    presence: true,
    length: { maximum: 25 }

  validates :about_me,
    presence: true,
    length: { minimum: 20 }

  validates :email,
    presence: true

  # make test for phone, zip, and profile pic
  def at_least_2_skills
    if skill_list.count >= 2
      true
    else
      errors.messages[:skill_error] = ["not enough skills"]
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
