class CourseBucket < ActiveRecord::Base
  belongs_to :student
  belongs_to :semester
  has_and_belongs_to_many :courses

  validates_presence_of :student_id
  validates_presence_of :semester_id
end
