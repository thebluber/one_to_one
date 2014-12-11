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
end
