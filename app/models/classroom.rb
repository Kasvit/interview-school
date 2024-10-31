# == Schema Information
#
# Table name: classrooms
#
#  id          :integer          not null, primary key
#  room_number :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Classroom < ApplicationRecord
    has_many :sections

    validates :room_number, presence: true, uniqueness: true
end
