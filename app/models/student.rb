class Student < ActiveRecord::Base
  belongs_to :user
  has_many :course_buckets
  after_create :init_course_bucket

  def current_course_bucket
    self.course_buckets.last
  end
  private
  def init_course_bucket
    self.course_buckets.create
  end
end
