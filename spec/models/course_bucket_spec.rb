require 'rails_helper'

RSpec.describe CourseBucket, :type => :model do
  it { should belong_to(:student) }
  it { should validate_presence_of(:student_id) }
  it { should have_and_belong_to_many(:courses) }
  describe "calculate_semester" do
    it "should calculate the correct semester" do
      bucket = create(:course_bucket)
      expect(bucket.semester).to eql "WS2014/2015"

      t = Time.local(2010, 8, 1, 10)
      Timecop.travel(t)
      bucket = create(:course_bucket)
      expect(bucket.semester).to eql "SS2010"

      t = Time.local(2014, 3, 1, 10)
      Timecop.travel(t)
      bucket = create(:course_bucket)
      expect(bucket.semester).to eql "WS2013/2014"

      Timecop.return
    end
  end
end
