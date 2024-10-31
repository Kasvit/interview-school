# == Schema Information
#
# Table name: sections
#
#  id           :integer          not null, primary key
#  days_of_week :text             default([])
#  end_time     :time
#  start_time   :time
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  classroom_id :integer
#  subject_id   :integer
#  teacher_id   :integer
#
class Section < ApplicationRecord
  belongs_to :teacher
  belongs_to :subject
  belongs_to :classroom
  has_many :student_sections
  has_many :students, through: :student_sections

  serialize :days_of_week, JSON

  # Validations
  validates :teacher_id, :subject_id, :classroom_id, :start_time, :end_time, presence: true
  validate :days_of_week_present
  validate :valid_days_of_week
  # validate :valid_time_range

  def on_day?(day)
    days_of_week.include?(day)
  end

  def teacher_name
    teacher.first_and_last_name
  end

  def subject_name
    subject.name
  end

  def classroom_number
    classroom.room_number
  end

  private

  def days_of_week_present
    errors.add(:days_of_week, "can't be blank") if days_of_week.blank? || days_of_week.empty?
  end

  def valid_days_of_week
    valid_days = %w[Monday Tuesday Wednesday Thursday Friday Saturday Sunday]
    unless days_of_week.is_a?(Array) && days_of_week.all? { |day| valid_days.include?(day) }
      errors.add(:days_of_week, "must be an array of valid weekdays")
    end
  end

  def valid_time_range
    duration = (end_time - start_time) / 60
    unless [50, 80].include?(duration)
      errors.add(:end_time, "must be 50 or 80 minutes after the start time")
    end
  end
end
