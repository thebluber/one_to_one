class Course < ActiveRecord::Base
  has_and_belongs_to_many :course_buckets
  has_and_belongs_to_many :mentors

  validates_presence_of :title, allow_blank: false
  validates_inclusion_of :active, in: [true, false]
end
