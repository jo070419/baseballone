class Evaluation < ApplicationRecord
  belongs_to :user

  with_options numericality: { only_integer: true, in: 0..9999 } do
    validates :good
    validates :usually
    validates :bad
  end
end
