class Agreement < ApplicationRecord
  belongs_to :recruitment
  belongs_to :user

  with_options presence: true do
    validates :agreement_flag
    validates :user_id
    validates :recruitment_id
  end
end
