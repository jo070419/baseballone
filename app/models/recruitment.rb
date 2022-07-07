class Recruitment < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  has_many   :applies
  has_many   :agreements
  belongs_to :capacity
  belongs_to :end_time
  belongs_to :level
  belongs_to :prefecture
  belongs_to :start_time
end
