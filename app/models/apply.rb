class Apply < ApplicationRecord
  belongs_to :user
  belongs_to :recruitment
  has_one :message_room
end
