require 'rails_helper'

RSpec.describe Student, :type => :model do
  it { should belong_to(:user) }
  it { should have_many(:course_buckets) }
end
