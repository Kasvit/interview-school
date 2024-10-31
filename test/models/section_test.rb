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
require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
