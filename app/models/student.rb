class Student < ActiveRecord::Base
  belongs_to :user
  has_many :course_buckets
  after_create :init_course_bucket

  private
  def init_course_bucket
    self.course_buckets.create
  end
end
