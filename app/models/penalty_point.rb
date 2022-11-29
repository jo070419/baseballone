class PenaltyPoint < ApplicationRecord
  has_many :penalty_point_logs
  belongs_to :user

  validates :point, presence: true, numericality: { only_integer: true, in: 0..19 }
end
