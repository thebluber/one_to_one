require 'rails_helper'

RSpec.describe Semester, :type => :model do
  it{ should validate_presence_of(:start) }
  it{ should have_many(:course_buckets) }
  it "should return the current_semester" do
    old = create(:semester, start: '2014-4-10')
    current = create(:semester, start: '2014-10-10')
    future = create(:semester, start: '2015-4-10')
    t = Time.local(2014, 12, 1, 10, 5, 0)
    Timecop.travel(t)
    expect(Semester.current_semester).to eql current
    t = Time.local(2015, 5, 1, 10, 5, 0)
    Timecop.travel(t)
    expect(Semester.current_semester).to eql future
    Timecop.return
  end
end
