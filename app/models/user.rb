class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_skills, dependent: :destroy
  has_many :skills, through: :user_skills
  has_many :projects

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

# make test for phone, zip, and profile pic
end
