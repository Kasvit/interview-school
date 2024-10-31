# == Schema Information
#
# Table name: students
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_students_on_email  (email) UNIQUE
#
class Student < ApplicationRecord
  has_many :student_sections
  has_many :sections, through: :student_sections

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
