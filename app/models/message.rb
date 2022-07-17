class Message < ApplicationRecord
  validates :text, presence: true, length: {maximum: 500}
  belongs_to :user
  belongs_to :message_room
end
