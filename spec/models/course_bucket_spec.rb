require 'rails_helper'

RSpec.describe CourseBucket, :type => :model do
  it { should belong_to(:student) }
  it { should belong_to(:semester) }
  it { should validate_presence_of(:student_id) }
  it { should have_and_belong_to_many(:courses) }
end
