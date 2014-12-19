require 'rails_helper'

RSpec.describe Student, :type => :model do
  it { should belong_to(:user) }
  it { should have_many(:course_buckets) }

  it "should return current course bucket of user" do
    semester = create(:semester)
    user = create(:user)
    bucket = create(:course_bucket, student: user.student, semester: semester)
    expect(user.student.course_buckets.count).to eql 1
    expect(user.student.current_course_bucket).to eql bucket
  end

  it "should create a new course bucket for given semester" do
    semester = create(:semester)
    user = create(:user)
    user.student.new_course_bucket semester
    expect(user.student.course_buckets.count).to eql 1
    expect(user.student.course_buckets.last.semester).to eql semester
  end

end
