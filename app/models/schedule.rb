class Schedule < ActiveRecord::Base
  validates :ws, presence: true, inclusion: { in: 1..12 }
  validates :ss, presence: true, inclusion: { in: 1..12 }
end
