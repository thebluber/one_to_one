class Semester < ActiveRecord::Base
  has_many :course_buckets
  validates :start, presence: true

  def self.current_semester
    Semester.where("start <= ?", DateTime.now).last
  end
end
