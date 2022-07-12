class ApplyMessage
  include ActiveModel::Model
  attr_accessor :user_id, :recruitment_id, :message_room_id, :text

  with_options presence: true do
    validates :user_id
    validates :recruitment_id
    validates :message_room_id
    validates :text, length: {maximum: 500}
  end

  def save
    # message_roomsテーブルに募集者と応募者の情報を保存
    message_room = MessageRoom.create()
  end
end