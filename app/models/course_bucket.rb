class CourseBucket < ActiveRecord::Base
  belongs_to :student
  has_and_belongs_to_many :courses

  validates_presence_of :student_id

  after_create :calculate_semester

  private
  def calculate_semester
    current_year = Time.now.year
    current_month = Time.now.month
    if current_month < 4
      self.semester = "WS#{current_year - 1}/#{current_year}"
    elsif current_month >= 4 && current_month <= 9
      self.semester = "SS#{current_year}"
    else
      self.semester = "WS#{current_year}/#{current_year + 1}"
    end
    save
  end
end
