class CreateMessageRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :message_rooms do |t|
      t.references :apply, null: false, foreign_key: true
      t.timestamps
    end
  end
end
