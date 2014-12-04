class Student < ActiveRecord::Base
  belongs_to :user
  has_many :course_buckets
end
