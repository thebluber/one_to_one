require 'rails_helper'

RSpec.describe Semester, :type => :model do
  it{ should validate_presence_of(:start) }
  it{ should have_many(:course_buckets) }
end
