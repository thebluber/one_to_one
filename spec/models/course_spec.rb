require 'rails_helper'

RSpec.describe Course, :type => :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:active) }
  it { should have_and_belong_to_many(:course_buckets) }
  it { should have_and_belong_to_many(:mentors) }
end
