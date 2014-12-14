require 'rails_helper'

RSpec.describe Student, :type => :model do
  it { should belong_to(:user) }
  it { should have_many(:course_buckets) }
  it "should have an empty course bucket" do
    user = create(:user)
    expect(user.student.course_buckets.count).to eql 1
  end
end
