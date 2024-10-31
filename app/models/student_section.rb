# == Schema Information
#
# Table name: student_sections
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  section_id :integer          not null
#  student_id :integer          not null
#
# Indexes
#
#  index_student_sections_on_section_id                 (section_id)
#  index_student_sections_on_student_id                 (student_id)
#  index_student_sections_on_student_id_and_section_id  (student_id,section_id) UNIQUE
#
# Foreign Keys
#
#  section_id  (section_id => sections.id)
#  student_id  (student_id => students.id)
#
class StudentSection < ApplicationRecord
  belongs_to :student
  belongs_to :section
end
