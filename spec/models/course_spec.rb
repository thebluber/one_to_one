require 'rails_helper'

RSpec.describe Course, :type => :model do
  it { should validate_presence_of(:title) }
  it { should ensure_inclusion_of(:active).in_array([true, false]) }
  it { should have_and_belong_to_many(:course_buckets) }
  it { should have_and_belong_to_many(:mentors) }
  describe "blank title" do
    it "should not allow blank title" do
      course = create(:active_course)
      course.title = ""
      expect(course.save).to eql false
    end
  end

  describe "students" do
    let(:user1){ create(:user) }
    let(:user2){ create(:user) }
    let(:course){ create(:active_course) }
    before do
      user1.student.course_buckets.create
      user1.student.course_buckets.map{|bucket| bucket.courses << course }
      user2.student.course_buckets.map{|bucket| bucket.courses << course }
      course.reload
    end
    it "should return all students assigned to course" do
      expect(course.students).to eql([user1.student, user2.student])
    end
  end
end
