require 'rails_helper'

RSpec.describe Mentor, :type => :model do
  it { should belong_to(:user) }
  it { should have_and_belong_to_many(:courses) }
end
