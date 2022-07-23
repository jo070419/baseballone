class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :message_room
end
