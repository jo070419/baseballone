class CreateRecruitments < ActiveRecord::Migration[6.0]
  def change
    create_table :recruitments do |t|
      t.string     :title,                null: false
      t.integer    :level_id,             null: false
      t.integer    :capacity_id,          null: false
      t.integer    :prefecture_id,        null: false
      t.string     :ball_park,            null: false
      t.date       :event_date,           null: false
      t.string     :start_time_id,        null: false
      t.string     :end_time_id,          null: false
      t.date       :recruitment_deadline, null: false
      t.text       :recruitment_text,     null: false
      t.references :user,                 null: false, foreign_key: true
      t.references :category,             null: false, foreign_key: true
      t.timestamps
    end
  end
end
