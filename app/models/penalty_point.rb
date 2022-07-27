class PenaltyPoint < ApplicationRecord
  has_many :penalty_point_logs
  belongs_to :user
end
