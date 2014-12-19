class Student < ActiveRecord::Base
  belongs_to :user
  has_many :course_buckets

  def current_course_bucket
    self.course_buckets.last
  end

  def new_course_bucket semester
    self.course_buckets.create(semester_id: semester.id)
  end
end
