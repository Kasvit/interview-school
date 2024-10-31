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

  # serialize :days_of_week, JSON
  attribute :end_time, :time_only
  attribute :start_time, :time_only

  # Validations
  validates :teacher_id, :subject_id, :classroom_id, :start_time, :end_time, presence: true
  validate :days_of_week_present
  validate :valid_days_of_week
  validate :validate_start_date
  validate :valid_time_range
  validate :time_within_operating_hours

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

  def validate_start_date
    if start_time > end_time
      errors.add(:start_time, "can't be after end time")
    end
  end

  def valid_time_range
    duration = end_time - start_time
    unless [Tod::TimeOfDay.new(0, 50), Tod::TimeOfDay.new(1, 20)].include?(duration)
      errors.add(:end_time, "must be 50 or 80 minutes after the start time")
    end
  end

  def time_within_operating_hours
    operating_hours = Tod::Shift.new(Tod::TimeOfDay.new(7, 30), Tod::TimeOfDay.new(20, 40))
    section_hours = Tod::Shift.new(start_time, end_time)

    if !operating_hours.contains?(section_hours)
      errors.add(:start_time, "must be in range 7:30 - 22:00")
      errors.add(:end_time, "must be in range 7:30 - 22:00")
    end
  end
end
