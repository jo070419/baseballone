class ApplyMessage
  include ActiveModel::Model
  attr_accessor :user_id, :recruitment_id, :message_room_id, :text

  with_options presence: true do
    validates :user_id
    validates :recruitment_id
    validates :text, length: {maximum: 500}
  end

  def save
    # 応募情報保存
    apply = Apply.create(user_id: user_id, recruitment_id: recruitment_id)
    # message_room作成
    message_room = MessageRoom.create(recruitment_id: recruitment_id)
    # entriesに応募者を保存
    Entry.create(user_id: user_id, message_room_id: message_room.id)
    # entriesに募集者を保存
    Entry.create(user_id: apply.recruitment.id, message_room_id: message_room.id)
    # メッセージを保存
    Message.create(text: text, user_id: user_id, message_room_id: message_room.id)
  end
end