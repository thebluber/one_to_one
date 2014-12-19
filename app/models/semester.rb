class Semester < ActiveRecord::Base
  has_many :course_buckets
  validates :start, presence: true
end
