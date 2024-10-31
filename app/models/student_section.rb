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

  validate :no_time_overlap

  private

  def no_time_overlap
    student.sections.each do |existing_section|
      next if (existing_section.days_of_week & section.days_of_week).empty?

      new_section_time = Tod::Shift.new(section.start_time, section.end_time)
      existing_section_time = Tod::Shift.new(existing_section.start_time, existing_section.end_time)

      if new_section_time.overlaps?(existing_section_time)
        errors.add(:base, "This section conflicts with an existing section in the student's schedule.")
        break
      end
    end
  end

end
