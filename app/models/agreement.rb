class Agreement < ApplicationRecord
  belongs_to :recruitment
  belongs_to :user
  belongs_to :apply

  with_options presence: true do
    validates :user_id
    validates :recruitment_id
  end
  validates :agreement_flag, inclusion: {in: [true, false]}
  validates :cancel_flag, inclusion: {in: [true, false]}
end
