require 'rails_helper'

RSpec.describe Schedule, :type => :model do
  it { should validate_presence_of(:ws) }
  it { should validate_presence_of(:ss) }
  it { should ensure_inclusion_of(:ws).in_range(1..12) }
  it { should ensure_inclusion_of(:ss).in_range(1..12) }
end
